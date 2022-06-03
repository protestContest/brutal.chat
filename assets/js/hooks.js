export default {
  ScrollDown: {
    updated() {
      this.el.scrollTo(0, this.el.scrollHeight)
      refocus()
    }
  },
  ResetBorder: {
    mounted() {
      resetBorder()
    },
    updated() {
      resetBorder()
    }
  }
};

function resetBorder() {
  const box = document.querySelector(".active")
  if (box) box.classList.add("transition")
}
