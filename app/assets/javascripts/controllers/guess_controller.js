(() => {
  stimulus.register("guess", class extends Stimulus.Controller {

    static get targets() {
      return [ "obfuscatedTargetWord", "guessedLetter", "guessedLetters", "errorContainer", "errorCount", "errorExplanation", "livesRemaining" ]
    }
    
    connect() {
      this.get_obfuscated_word()
    }

    get_obfuscated_word() {
      var self = this
      var url = window.location.href + "/obfuscated_target_word"
      var xhttp;

      xhttp=new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          self.setObfuscatedTargetWord(JSON.parse(this.response).target_word)
        }
      };
      xhttp.open("GET", url, true);
      xhttp.send();
    }

    setObfuscatedTargetWord(string) {
      this.obfuscatedTargetWordTarget.innerHTML = string
    }

    handle_guess(event) {
      event.preventDefault()

      this.post_guess(event.target.form.action, event.target.form[1].value)
    }

    post_guess(url, token) {
      var self = this

      var urlEncodedDataPairs = [];
      var urlEncodedData = "";
      urlEncodedDataPairs.push(encodeURIComponent("authenticity_token") + '=' + encodeURIComponent(token));
      urlEncodedDataPairs.push(encodeURIComponent(this.guessedLetterTarget.name) + '=' + encodeURIComponent(this.guessedLetterTarget.value));
      urlEncodedData = urlEncodedDataPairs.join('&').replace(/%20/g, '+');

      //var url = window.location.href + "/guesses"
      var xhttp;
      xhttp=new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        // If the guess was successful
        if (this.readyState == 4 && this.status == 204) {
          console.log()
          self.get_obfuscated_word()
          self.addGuessToGuessedLetters(self.guessedLetterTarget.value)
          self.guessedLetterTarget.value = null
          self.errorExplanationTarget.setAttribute("hidden", true);
        } else {
          self.setErrors(JSON.parse(this.response));
        }
      };
      xhttp.open("POST", url + ".json", true);
      xhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhttp.send(urlEncodedData);
    }

    addGuessToGuessedLetters() {
      this.guessedLettersTarget.innerHTML = this.guessedLettersTarget.innerHTML + " " + this.guessedLetterTarget.value
    }

    setErrors(errors) {
      this.errorContainerTarget.innerHTML = ""
      var count = 0

      for(var key in errors) {
      for(var index in errors[key]) {
          console.log(errors[key][index])

          var listViewItem=document.createElement('li');
          listViewItem.appendChild(document.createTextNode(errors[key][index]));
          this.errorContainerTarget.appendChild(listViewItem);
          count++
        }
      }
      this.errorCountTarget.innerHTML = count;
      this.errorExplanationTarget.removeAttribute("hidden");
    }
  })
})()