
def parse_int(string)
  ##handle highest number (inclusive) one million
  return 1000000 if string == "one million"

  ###handle thousands
  if string.include?('thousand')
    tho = string.split("thousand")
    arr2 = tho[1].to_s if tho.length > 1
    arr1 = tho[0].to_s

    first = nummaker(arr1)
    second = 'thousand'
    third = nummaker(arr2)

    if string[-3..-1] == 'and'
      first = first.to_s
      first << '00'
      first = first.to_i
      return first
    end
    first = first.to_s
    third = third.to_s
    whole = first + third
    whole = whole.to_i
    return whole
  end



  ##################to handle single cases, teens, 20 30s etc, hundreds and thousands broken up into pieces
  def nummaker(string)
  ans = ''
  arr = string.split(" ")
  onescheck = {'one' => '1', 'two' => '2', 'ree' => '3', 'our' => '4', 'ive' => '5', 'six' => '6', 'ven' => '7', 'ght' => '8', 'ine' => '9', 'ero' => '0' }
  ones = {'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9', 'zero' => '0' }
  tens = {'ten' => '10', 'eleven' => '11', 'twelve' => '12', 'thirteen' => '13', 'fourteen' => '14', 'fifteen' => '15', 'sixteen' => '16', 'seventeen' => '17', 'eighteen' => '18', 'nineteen' => '19'}
  twen = { 'twenty' => '2', 'thirty' => '3','forty' => '4', 'fifty' => '5', 'sixty' => '6', 'seventy' => '7', 'eighty' => '8', 'ninety' => '9'}
  hund = {' hundred' => '00'}
  #add in ones if nothing greater
  if string.length <= 6 and string != 'ten' and string != "eleven" and string != "twelve" and !string.include?('ty')
   ones.each do |k,v|
    arr.each do |x|
      ans << v if x == k
    end
   end
   return ans.to_i
  end

###########check for just teens
  if !string.include?('hundred') and string.length <= 9
   if string.include?('teen') or string.include?('eleven') or string.include?('twelve') or string.include?('ten')
    tens.each do |k,v|
      arr.each do |x|
        ans << v if x == k
      end
     end
     return ans.to_i
   end
  end
#######   #check for just 20 30 etc ending in ty
   if string.include?('ty') and string.length <=7
    twen.each do |k,v|
      arr.each do |x|
        ans << v if x == k
      end
    end
    ans << '0'
    return ans.to_i
   end
 ###check for just 20 30 etc but with a single digit ending
   if string.include?('ty') and string.length <=15
    twen.each do |k,v|
      arr.each do |x|
        ans << v if x.include?(k)
      end
    end
    onescheck.each do |k,v|
      ans << v if arr[-1][-3..-1] == k
    end
   return ans.to_i
   end

  ###check if hundreds no thousands ##################################
  if string.include?('hundred')
    if arr[0] != 'hundred' && !arr.include?('thousand')
      ans << ones[arr[0]] #+ '00'
      ans << '00' if string[-3..-1] == 'red'
 #######check for teens and 20 30s etc
    if string.include?('teen') or string.include?('ten') or string.include?('eleven') or string.include?('twelve')
    tens.each do |k,v|
      arr.each do |x|
        ans << v if x == k
      end
     end
   end
  ###check for just 20 30 etc ending in ty ########################
   if string.include?('ty') and string[-2..-1] == 'ty'#and string.length <=7
    twen.each do |k,v|
      arr.each do |x|
        ans << v if x.include?(k)
      end
    end
    ans << '0'
    return ans.to_i
   end
####check for just 20 30 etc with single digit ending
   if string.include?('ty') and string.include?("-") #and string[-2..-1] == "ty" #and string.length <=15
    twen.each do |k,v|
      arr.each do |x|
        ans << v if x.include?(k)
      end
    end
    if string.include?('ty') and string[-2..-1] != "ty"
     onescheck.each do |k,v|
      ans << v if arr[-1][-3..-1] == k
     end
    end
    return ans.to_i
   end

########check for 0-ones last two digits
      if string[-6..-1].include?('one') or string[-6..-1].include?('two') or string[-6..-1].include?('three') or string[-6..-1].include?('four') or string[-6..-1].include?('five') or string[-6..-1].include?('six') or string[-6..-1].include?('seven') or string[-6..-1].include?('eight') or string[-6..-1].include?('nine')
       ans << '0'
        ones.each do |k,v|
             ans << v if arr[-1]==k
        end
        return ans.to_i
      end
      return ans.to_i
    end

 ########  #check for teens
  if string.include?('teen') or string.include?('ten') or string.include?('eleven') or string.include?('twelve')
    tens.each do |k,v|
      arr.each do |x|
        ans << v if x == k
      end
     end
   end
   #check for 20 30 etc
   if string.include?('-')
    twen.each do |k,v|
      arr.each do |x|
        ans << v if x.include?(k)
      end
    end
   end
  #add in ones check no teens and not hundreds
  if !string[-3..-1].include?('ty') and !string[-3..-1].include?('red')
   ones.each do |k,v|
    arr.each do |x|
      ans << v if x == k
    end
   end
  end

  end

  return ans.to_i

  end

  nummaker(string) if !string.include?('thousand')
end
