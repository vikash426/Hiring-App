String checkEmail(String val) {
    if (val.length.toInt() > 0) {
      var check = RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(val);
      if (!check) {
        return "invalid Email";
      }
      return null;
    } else
      return "Please Enter Email";
  }

  String checkPass(String val) {
    if (val.length.toInt() > 0) {
      if (val.length.toInt() < 6) {
        return "Password too short";
      }
      return null;
    } else
      return "Please enter Password ";
  }

  String confirmPassword(String value,String pass){
    if(value.length>0){

    
    if(value==pass){
      return null;
    }
    else
    return "Password Does Not Match";}
    else
    return "Please confirm password";
  }

  String checkNumber(String val){
    if(val.length>0){
    if(val.length<11){
      return "Enter 11 digit Phone Number ";
    }
    else
    return null;}
    else
    return "Please Enter Phone Number";
  }

  String checkdescription(String val){
    if(val.length>0){
      if(val.length<20){
        return "Description Too Short";
      }
      else
      return null;
    }
    else
    return "Please Enter Description";
  }
  String checkLength(String val){
    if(val.length>0)
    return null;
    else
    return "PLease Fill all the fields";
  }