class Book < Sequel::Model
      def self.id_exists?(id)
        return false if id.nil? # check the id is not nil
        return false unless Validation.str_is_integer?(id) # check the id is an integer
        return false if Player[id].nil? # check the database has a record with this id
    
        true # all checks are ok - the id exists
      end

      def load(params)
        self.name = params.fetch("name", "").strip
        self.genre = parms.fetch("genre", "").strip
      end

      # returns either the author or nil if they do not exist
      def get_author()
        User.first(id: self.author)
      end

      def get_chapter_count()
        chapters = Chapter.where(book: self.id)
        chapters.count
      end

      def get_chapters()
        Chapter.where(book: self.id)
      end

      def get_chapter(number)
        Chapter.first(book: self.id, ch_number: number)
      end

      def report()
        self.flagged = 1
        # update staff panel somehow or send an email
      end

      def get_link()
        "/read?id=#{self.id}"
      end

      def get_full_link(prevLink)
        "#{prevLink}read?id=1"
      end

      def get_link_with_chapter(chapter)
        "/read?id=#{self.id}&chapter=#{chapter}"
      end

      def get_link_and_chapter(chapter)
        "/edit?id=#{self.id}&chapter=#{chapter}"
      end

      def get_last_updated(now = DateTime.now(Date::ENGLAND))
        last_updated = DateTime.strptime(self.last_updated, "%d/%m/%Y:%H:%M")
        difference_in_mins = (now - last_updated) * 24 * 60
        puts ((difference_in_mins / 60 / 24 / (365 / 12))).floor
        if difference_in_mins / 60 / 24 / 365 >= 1 then
            year_difference = (difference_in_mins / 60 / 24 / 365).floor
            return "#{year_difference} year#{year_difference > 1 ? 's' : ''} ago"
        elsif (difference_in_mins / 60 / 24 / (365 / 12)) >= 1 then
            month_difference = ((difference_in_mins / 60 / 24 / (365 / 12))).floor
            return "#{month_difference} month#{month_difference > 1 ? 's' : ''} ago"
        elsif difference_in_mins / 60 / 24 / (365 / 12 / 4) >= 1 then
            week_difference = (difference_in_mins / 60 / 24 / (365 / 12 / 4)).floor
            return "#{week_difference} week#{week_difference > 1 ? 's' : ''} ago"
        elsif difference_in_mins / 60 / 24 >= 1 then
            day_difference = (difference_in_mins / 60 / 24).floor
            return "#{day_difference} day#{day_difference > 1 ? 's' : ''} ago"
        elsif difference_in_mins / 60 >= 1 then
            hour_difference = (difference_in_mins / 60).floor
            return "#{hour_difference} hour#{hour_difference > 1 ? 's' : ''} ago"
        else
            return "#{difference_in_mins.ceil} minute#{difference_in_mins > 1 ? 's' : ''} ago"
        end
      end

      def update_last_updated()
        now = DateTime.now()
        self.last_updated = now.strftime("%d/%m/%Y:%H:%M")
      end
end

