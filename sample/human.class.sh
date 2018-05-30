
class human {

  name=""
  sex=""
  age=""
  job=""
  home=""
  balance=
  place=""
  relationships=()

  def changeJob {
  }


  def getmoney {
    self.balance += $1
    return $EX_OK
  }

  def goto {
  if [ $(place.exist? $1) ]; then
    place="$1"
    return $EX_OK
  else
    return $EX_UNAVAILABLE
  fi

  }
}
