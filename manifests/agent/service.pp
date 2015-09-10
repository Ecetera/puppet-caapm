
class caapm::agent::service inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with em::service em_as_service = $em_as_service":}
#  notify {"Running with em::service wv_as_service = $wv_as_service":}


}
