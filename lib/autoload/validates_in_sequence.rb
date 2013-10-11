module ActiveModel::Validations::ClassMethods

  def new_validates_with(*args, &block)
    # Original "validates_with" call
    ori_proc = Proc.new { |arr| old_validates_with *arr, &block }

    # Check whether caller is "validates"
    if is_validates_caller? caller.first
      hack_validates(*args, &ori_proc)
    else
      ori_proc.call(args)
    end
  end

  # alias chain, to change calling entry of validates_with
  alias old_validates_with validates_with
  alias validates_with new_validates_with

private

  # Check whether caller is "validates"
  def is_validates_caller?(call_info)
    # Fetch method name of caller
    if /:\d+:in\s+`(.*)'/ =~ call_info
      method = Regexp.last_match[1]
    end

    # Contains "block in validates" & "validates_xxx_of"
    method && (/ validates\z/ =~ method || /\Avalidates_\w*_of\z/ =~ method)
  end

  # Add logic to display only one error msg
  # for each field, each time, in sequence
  # Refer to the codes of "validates" in ActiveModel
  def hack_validates(*args)
    handled = false

    options = args.extract_options!
    # Need field symbol to add filter logic
    if options && options.has_key?(:attributes)

      # Split the fields for same validator
      options[:attributes].each do |attr|
        tmp = options.dup

        # Add "single err msg" logic, as a proc obj
        tmp[:unless] = Array(tmp[:unless]) << Proc.new { |obj| obj.errors.include? attr }
        # Merge the changed options back to arg list
        yield(args.dup << tmp.merge(attributes: Array(attr)))
        handled = true
      end
    end

    yield(args << options) unless handled
  end
end
