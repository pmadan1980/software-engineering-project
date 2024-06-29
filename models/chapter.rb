class Chapter < Sequel::Model
    def get_polls()
        Poll.where(chapter: self.id)
    end
end