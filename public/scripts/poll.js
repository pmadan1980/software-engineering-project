function toggleCustomBookInput() {
            var customBookInput = document.getElementById("custom-book-input");
            var bookDropdown = document.getElementById("book-name");
            if (bookDropdown.value === "custom") {
                customBookInput.style.display = "block";
            } else {
                customBookInput.style.display = "none";
            }
        }

        function addQuestion() {
            var pollSection = document.getElementById("poll-section");
            var newQuestion = document.createElement("div");
            newQuestion.classList.add('question');
            newQuestion.innerHTML = '<p>Poll Question:</p><input type="text" name="poll-question" placeholder="Enter your poll question">';
            var questionIndex = document.querySelectorAll('.question').length;
            newQuestion.innerHTML = `
              <div data-questionIndex="${questionIndex}">
                <p>Poll Question:</p>
                <input type="text" name="question-${questionIndex}[]" placeholder="Enter your poll question">
                <p>Poll Options:</p>
                <div class="options">
                  <input type="text" name="option-${questionIndex}[]" placeholder="Option 1" class="option">
                  <input type="text" name="option-${questionIndex}[]" placeholder="Option 2" class="option">
                </div>
                <button type="button" class="addOptionBtn" onclick="addOption(this)">Add Option</button>
              </div>
`
            pollSection.appendChild(newQuestion);
        }

        function addOption(btn) {
            var pollSection = btn.parentElement.querySelector('.options');
            var questionIndex = btn.parentElement.getAttribute('data-questionIndex');
            var newOption = document.createElement("input");
            var optionCount = pollSection.childElementCount;
            if (optionCount < 5) {
                newOption.type = 'text';
                newOption.name = `option-${questionIndex}[]`;
                newOption.classList.add('option');
                newOption.placeholder = `Option ${pollSection.querySelectorAll('.option').length + 1}`;
                // newOption.innerHTML = '<p>Poll Option:</p><input type="text" name="poll-option' + questionIndex + '" placeholder="Enter option">';
                pollSection.appendChild(newOption);
            }
        }

        var pollHidden = true;

        function togglePollSection() {
            var pollSection = document.getElementById("poll-section");
            var addQuestionButton = document.getElementById("add-question-button");
            if (pollHidden) {
                pollSection.style.display = "block";
                addQuestionButton.style.display = "block"; // Show the button
                pollHidden = false;
            } else {
                pollSection.style.display = "none";
                addQuestionButton.style.display = "none"; // Hide the button
                pollHidden = true;
            }
        }