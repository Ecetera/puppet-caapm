require 'uri'

module Puppet::Parser::Functions
  newfunction(:to_windows_escaped, :type => :rvalue, :doc => <<-EOS
Parse filepath to retrieve information about the file.
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "to_windows_escaped(): Wrong number of arguments " +
      "given (#{arguments.size} for 1, 2, 3)") if arguments.size < 1 || arguments.size > 3

    return arguments[0].gsub('/', '\\\\\\\\')

  end
end
