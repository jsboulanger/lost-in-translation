module LostInTranslation
  class CodeParser
    def initialize(detectors)
      @detectors = detectors
      @detectors = [@detectors] unless @detectors.is_a?(Array)
    end

    def process(exp)
      return unless exp.is_a?(Array)
      
      case exp[0]
      when :call
        process_call(exp)
      else
        process_default(exp)
      end      
    end

    def process_default(exp)
      exp.each { |sub| process(sub) if sub.is_a?(Array) }
    end

    def process_call(exp)
      @detectors.map { |detector| detector.method_call(*exp[1..3]) }
      process_default(exp)
    end
  end
end
