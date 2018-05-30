
class place {

  place=("office" "home" "VRC")

  def add_place {
    self.place=($add_place $1)
    return $EX_OK
  }


  def exist? {
    for exist-place in ${self.place[@]}; do
      if [ "$exist-place" = "$1" ]; then
        return $EX_OK
      fi
    done

    return $EX_UNAVAILABLE
  }

}
