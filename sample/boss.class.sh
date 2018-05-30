
class boss -> human {

  def fire {
    if [ $(${1}.exist?) ] && [ "$(${1}.boss)" = "$name" ]; then
      $1.set job ""
      return $EX_OK
    fi
      return $EX_UNAVAILABLE
  }

  def employ {
    if [ $(${1}.exist?) ] && [ "$(${1}.job)" = "" ]; then
      $1.set job "job"
      $1.set boss "$name"
  }
}
