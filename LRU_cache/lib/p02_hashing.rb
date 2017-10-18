require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?
    out = self.map.with_index {|el, idx| el.is_a?(Integer) ? el * idx : el.hash * idx}
    out.inject(&:+)
  end
end

class String
  ALPHA = ('a'..'z').to_a
  def hash
    total = 0
    self.downcase.chars.each_with_index do |char, idx|
      total += ALPHA.index(char) * (idx + 1)
    end
    total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total = 0
    # debugger
    self.each do |k, v|
      # if k.is_a?(Integer)
      total += k.to_s.hash * v.hash
      # else
      #   total += k.hash * v.hash
      # end
    end
    total
  end

end
