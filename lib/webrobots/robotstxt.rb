#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.6
# from Racc grammer file "".
#

require 'racc/parser.rb'


require 'strscan'
require 'uri'

class WebRobots
  class Error < StandardError
  end

  class ParseError < Error
  end

  class RobotsTxt
class Parser < Racc::Parser

module_eval(<<'...end robotstxt.ry/module_eval...', 'robotstxt.ry', 164)

      def initialize(target = nil)
        super()
        @target = target
      end

      def parse!(input, site)
        parse(input, site)
      rescue Error => e
        RobotsTxt.new(site, nil, :error => e, :target => @target)
      end

      KNOWN_TOKENS = %w[User-agent Allow Disallow Crawl-delay Sitemap]
      RE_KNOWN_TOKENS = /#{KNOWN_TOKENS.join('|')}/i

      def parse(input, site)
        @q = []
        @errors = []
        @lineno = 1
        @site = site

        string = input.respond_to?(:read) ? input.read : input
        s = StringScanner.new(string)
        value_expected = false

        until s.eos?
          if t = s.scan(/[ \t]*\r?\n/)
            if value_expected
              @q << [:VALUE, '']
            end
            @q << [:EOL, t]
            value_expected = false
          elsif t = s.scan(/[ \t]+/)
            @q << [:SPACE, t]
          elsif t = s.scan(/:/)
            @q << [t, t]
            value_expected = true
          elsif t = s.scan(/#.*/)
            if value_expected
              @q << [:VALUE, '']
            end
            @q << [:COMMENT, t]
          else
            if value_expected
              if t = s.scan(/.*?(?=[ \t]*(?:#|$))/)
                @q << [:VALUE, t]
              else
                parse_error @lineno, "unexpected characters: %s" % s.check(/.*/)
              end
              value_expected = false
            else
              if t = s.scan(RE_KNOWN_TOKENS)
                @q << [t.downcase, t]
              elsif t = s.scan(/[^\x00-\x1f\x7f()<>@,;:\\"\/\[\]?={}]+/)
                @q << [:TOKEN, t]
              else
                parse_error "unexpected characters: %s" % s.check(/.*/)
              end
            end
          end
        end

        @q << [:EOL, ''] if !@q.empty? && @q.last.first != :EOL

        @pos = -1

        do_parse
      rescue Racc::ParseError => e
        raise ParseError, e.message
      end

      def next_token
        @q[@pos += 1]
      end

      def on_error(token_id, value, stack)
        parse_error "unexpected %s: %s" % [token_to_str(token_id), value]
      end

      def parse_error(message)
        message = "%s line %d: %s" % [@site.to_s, @lineno, message]
        if @lax
          @errors << message
        else
          raise Racc::ParseError, message
        end
      end

...end robotstxt.ry/module_eval...
##### State transition tables begin ###

racc_action_table = [
     6,    13,   -11,    17,    53,     6,   -13,    37,    38,    39,
    40,    13,   -11,    17,    47,    28,    28,    37,    38,    39,
    40,    13,   -11,    17,    50,    51,    52,    37,    38,    39,
    40,    13,   -11,    17,    13,    54,    25,    37,    38,    39,
    40,    13,   -11,    17,    13,    13,   -13,    13,   -11,    17,
     6,    13,   -14,    17,     6,    13,    13,    17,     6,    13,
    13,    17,     6,    13,    13,    17,     6,    13,    24,    17,
     6,    13,    63,    17,    64,    65,    66,    67,     6,    10,
     6,     7,     6 ]

racc_action_check = [
    22,    22,    22,    22,    40,    24,    22,    22,    22,    22,
    22,    26,    26,    26,    28,    20,    26,    26,    26,    26,
    26,    46,    46,    46,    37,    38,    39,    46,    46,    46,
    46,    30,    30,    30,    25,    42,    17,    30,    30,    30,
    30,     8,     8,     8,    47,    50,     8,    14,    14,    14,
    63,    63,    14,    63,    54,    54,    51,    54,    64,    64,
    52,    64,    65,    65,    53,    65,    66,    66,    16,    66,
    67,    67,    55,    67,    56,    57,    58,    59,    12,     7,
     3,     1,     0 ]

racc_action_pointer = [
    80,    81,   nil,    78,   nil,   nil,   nil,    79,    38,   nil,
   nil,   nil,    76,   nil,    44,   nil,    64,    30,   nil,   nil,
     7,   nil,    -2,   nil,     3,    31,     8,   nil,     8,   nil,
    28,   nil,   nil,   nil,   nil,   nil,   nil,    18,    19,    20,
    -2,   nil,    28,   nil,   nil,   nil,    18,    41,   nil,   nil,
    42,    53,    57,    61,    52,    65,    67,    68,    69,    70,
   nil,   nil,   nil,    48,    56,    60,    64,    68,   nil,   nil,
   nil,   nil,   nil ]

racc_action_default = [
    -5,   -45,    -1,    -6,    -7,    -9,   -10,   -45,    -3,    -8,
    73,    -2,    -5,   -12,   -24,   -15,   -45,   -45,   -19,   -20,
   -45,    -4,    -6,   -16,   -45,   -11,   -30,   -26,   -45,   -21,
   -22,   -23,   -32,   -35,   -36,   -37,   -38,   -45,   -45,   -45,
   -45,   -17,   -45,   -25,   -27,   -28,   -31,   -11,   -33,   -34,
   -11,   -11,   -11,   -11,   -11,   -45,   -45,   -45,   -45,   -45,
   -18,   -43,   -44,   -11,   -11,   -11,   -11,   -11,   -29,   -39,
   -40,   -41,   -42 ]

racc_goto_table = [
    15,    42,     9,    48,     3,    12,    23,    11,     5,    27,
    18,     5,    26,     2,    15,    44,    22,    19,    45,    48,
     5,     9,    49,    55,    29,    21,    56,    57,    58,    59,
     5,    31,    41,    60,    43,    30,     8,     1,    49,    46,
   nil,   nil,    68,    69,    70,    71,    72 ]

racc_goto_check = [
    12,     9,     7,    20,     6,     5,    12,     3,     8,    19,
    14,     8,    17,     2,    12,    19,     6,    15,    12,    20,
     8,     7,    12,     9,    14,     2,     9,     9,     9,     9,
     8,    15,     8,    13,    18,    16,     4,     1,    12,    16,
   nil,   nil,    13,    13,    13,    13,    13 ]

racc_goto_pointer = [
   nil,    37,    13,    -1,    34,    -3,     4,    -1,     8,   -24,
   nil,   nil,    -8,   -21,     2,     9,    13,    -8,     8,   -11,
   -27,   nil,   nil,   nil,   nil ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,   nil,     4,    61,    16,
    20,    14,    62,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    32,    33,    34,    35,    36 ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 17, :_reduce_1,
  3, 14, :_reduce_2,
  0, 16, :_reduce_none,
  2, 16, :_reduce_none,
  0, 15, :_reduce_none,
  1, 15, :_reduce_none,
  1, 19, :_reduce_none,
  2, 19, :_reduce_none,
  1, 20, :_reduce_none,
  1, 21, :_reduce_10,
  0, 22, :_reduce_none,
  1, 22, :_reduce_none,
  0, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 24, :_reduce_none,
  2, 24, :_reduce_none,
  3, 25, :_reduce_none,
  5, 25, :_reduce_18,
  1, 18, :_reduce_19,
  1, 18, :_reduce_20,
  3, 18, :_reduce_21,
  3, 18, :_reduce_22,
  3, 18, :_reduce_none,
  1, 28, :_reduce_none,
  3, 27, :_reduce_25,
  1, 30, :_reduce_26,
  2, 30, :_reduce_27,
  2, 30, :_reduce_none,
  5, 32, :_reduce_29,
  0, 31, :_reduce_none,
  1, 31, :_reduce_none,
  1, 29, :_reduce_32,
  2, 29, :_reduce_33,
  2, 29, :_reduce_none,
  1, 33, :_reduce_none,
  1, 33, :_reduce_none,
  1, 33, :_reduce_none,
  1, 33, :_reduce_none,
  5, 34, :_reduce_39,
  5, 35, :_reduce_40,
  5, 36, :_reduce_41,
  5, 37, :_reduce_42,
  1, 26, :_reduce_none,
  1, 26, :_reduce_none ]

racc_reduce_n = 45

racc_shift_n = 73

racc_token_table = {
  false => 0,
  :error => 1,
  :EOL => 2,
  :SPACE => 3,
  :COMMENT => 4,
  "sitemap" => 5,
  ":" => 6,
  :VALUE => 7,
  "user-agent" => 8,
  "allow" => 9,
  "disallow" => 10,
  "crawl-delay" => 11,
  :TOKEN => 12 }

racc_nt_base = 13

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "EOL",
  "SPACE",
  "COMMENT",
  "\"sitemap\"",
  "\":\"",
  "VALUE",
  "\"user-agent\"",
  "\"allow\"",
  "\"disallow\"",
  "\"crawl-delay\"",
  "TOKEN",
  "$start",
  "robotstxt",
  "opt_blanklines",
  "body",
  "@1",
  "blocks",
  "blanklines",
  "blankline",
  "eol",
  "opt_space",
  "opt_commentlines",
  "commentlines",
  "comment",
  "eol_opt_comment",
  "record",
  "commentblock",
  "rulelines",
  "agentlines",
  "opt_rulelines",
  "agentline",
  "ruleline",
  "allowline",
  "disallowline",
  "crawldelayline",
  "extension" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 7)
  def _reduce_1(val, _values, result)
    			    @sitemaps = []
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 11)
  def _reduce_2(val, _values, result)
    			    body = val[2]
			    result = RobotsTxt.new(@site, body,
			      :target => @target, :sitemaps => @sitemaps)
			  
    result
  end
.,.,

# reduce 3 omitted

# reduce 4 omitted

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 31)
  def _reduce_10(val, _values, result)
    			    @lineno += 1
			  
    result
  end
.,.,

# reduce 11 omitted

# reduce 12 omitted

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

# reduce 16 omitted

# reduce 17 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 47)
  def _reduce_18(val, _values, result)
    			    @sitemaps << val[3]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 52)
  def _reduce_19(val, _values, result)
    			    result = []
			    result << val[0]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 57)
  def _reduce_20(val, _values, result)
    			    result = []
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 63)
  def _reduce_21(val, _values, result)
    			    result << val[2]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 69)
  def _reduce_22(val, _values, result)
    			    val[2].each_with_index { |line, i|
			      warn "%s line %d: %s: orphan rule line" %
			        [@site.to_s, @rulelinenos[i], line.token] if $VERBOSE
			    }
			  
    result
  end
.,.,

# reduce 23 omitted

# reduce 24 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 84)
  def _reduce_25(val, _values, result)
    			    result = Record.new(val[1], val[2])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 89)
  def _reduce_26(val, _values, result)
    			    result = [val[0]]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 94)
  def _reduce_27(val, _values, result)
    			    result << val[1]
			  
    result
  end
.,.,

# reduce 28 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 101)
  def _reduce_29(val, _values, result)
    			    result = AgentLine.new(val[0], val[3])
			  
    result
  end
.,.,

# reduce 30 omitted

# reduce 31 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 109)
  def _reduce_32(val, _values, result)
    			    result = [result]
			    @rulelinenos = []
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 115)
  def _reduce_33(val, _values, result)
    			    result << val[1]
			    @rulelinenos << @lineno
			  
    result
  end
.,.,

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

# reduce 38 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 128)
  def _reduce_39(val, _values, result)
    			    result = AllowLine.new(val[0], val[3])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 133)
  def _reduce_40(val, _values, result)
    			    result = DisallowLine.new(val[0], val[3])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 138)
  def _reduce_41(val, _values, result)
    			    result = CrawlDelayLine.new(val[0], val[3])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 143)
  def _reduce_42(val, _values, result)
    			    result = ExtentionLine.new(val[0], val[3])
			  
    result
  end
.,.,

# reduce 43 omitted

# reduce 44 omitted

def _reduce_none(val, _values, result)
  val[0]
end

end   # class Parser

    def initialize(site, records, options = nil)
      @timestamp = Time.now
      @site = site
      @options = options || {}
      @last_checked = nil

      @error = @options[:error]
      @target = @options[:target]
      @sitemaps = @options[:sitemaps] || []

      if records && !records.empty?
        @records, defaults = [], []
        records.each { |record|
          if record.default?
            defaults << record
          elsif !@target || record.match?(@target)
            @records << record
          end
        }
        @records.concat(defaults)
      else
        @records = []
      end
    end

    attr_reader :timestamp, :site, :sitemaps
    attr_accessor :error

    def error!
      raise @error if @error
    end

    def target(user_agent = nil)
      if user_agent
        raise ArgumentError, "this instance is targeted for #{@target}" if @target
        user_agent
      else
        raise ArgumentError, "user_agent is mandatory for an untargeted instance" if !@target
        @target
      end
    end
    private :target

    def find_record(user_agent = nil)
      user_agent = target(user_agent)
      @records.find { |record|
        record.match?(user_agent)
      }
    end
    private :find_record

    def allow?(request_uri, user_agent = nil)
      record = find_record(user_agent) or return true
      allow = record.allow?(request_uri)
      if @last_checked and delay = record.delay
        delay -= Time.now - @last_checked
        sleep delay if delay > 0
      end
      @last_checked = Time.now
      return allow
    end

    def options(user_agent = nil)
      record = find_record(user_agent) or return {}
      record.options
    end

    DISALLOW_ALL = <<-TXT
User-Agent: *
Disallow: /
    TXT

    def self.unfetchable(site, reason, target = nil)
      Parser.new(target).parse(DISALLOW_ALL, site).tap { |robots_txt|
        robots_txt.error = reason
      }
    end

    class Record
      def initialize(agentlines, rulelines)
        @patterns = agentlines.map { |agentline| agentline.pattern }
        @acls = []
        @delay = nil
        @options = {}
        rulelines.each { |ruleline|
          case ruleline
          when AccessControlLine
            @acls << ruleline
          when CrawlDelayLine
            @delay = ruleline.delay
          else
            @options[ruleline.token.downcase] = ruleline.value
          end
        }
        @acls.sort! { |a, b|
          [
            b.value.length, b.is_a?(AllowLine) ? 1 : 0
          ] <=> [
            a.value.length, a.is_a?(AllowLine) ? 1 : 0
          ]
        }
      end

      attr_reader :delay, :options

      def match?(user_agent)
        @patterns.any? { |pattern|
          pattern.match(user_agent)
        }
      end

      def default?
        @patterns.include?(//)
      end

      def allow?(request_uri)
        @acls.each { |acl|
          if acl.match?(request_uri)
            return acl.allow?
          end
        }
        return true
      end
    end

    class Line
      def initialize(token, value)
        @token = token
        @value = value
        compile
      end

      attr_reader :token, :value

      def compile
        self
      end
    end

    class AgentLine < Line
      def compile
        if @value == '*'
          @pattern = //
        else
          @pattern = Regexp.new(Regexp.quote(@value), Regexp::IGNORECASE)
        end
        self
      end

      attr_reader :pattern
    end

    class AccessControlLine < Line
      def compile
        @empty = @value.empty?
        re_src = '\A'
        s = StringScanner.new(@value)
        until s.eos?
          if t = s.scan(/[^%*$]+/)
            re_src << Regexp.quote(t)
          elsif t = s.scan(/%([0-9a-f]{2})/i)
            c = s[1].to_i(16)
            if c == 0x2f
              re_src << '%2[fF]'
            else
              re_src << Regexp.quote('%c' % c)
            end
          elsif t = s.scan(/\*/)
            re_src << '.*'
          elsif t = s.scan(/\$/)
            re_src << '\z'
            break
          else
            re_src << Regexp.quote(s.scan(/./))
          end
        end
        @pattern = Regexp.new(re_src, Regexp::MULTILINE)
        self
      end

      def match?(request_uri)
        return false if @empty
        transformed = request_uri.gsub(/(%2[fF])|%([0-9a-f]{2})/i) { $1 || '%c' % $2.to_i(16) }
        !!@pattern.match(transformed)
      end
    end

    class AllowLine < AccessControlLine
      def allow?
        true
      end
    end

    class DisallowLine < AccessControlLine
      def allow?
        false
      end
    end

    class CrawlDelayLine < Line
      def compile
        case @value
        when /\A((0|[1-9][0-9]*)\.[0-9]+)/
          @delay = @value.to_f
        when /\A(0|[1-9][0-9]*)/
          @delay = @value.to_i
        else
          @delay = nil
        end
        self
      end

      attr_reader :delay
    end

    class ExtentionLine < Line
    end
  end
end
