#!/usr/bin/ruby


def convert(opt, line)
  case opt
    when [0, 1]
      puts line.gsub(/[A-Z]/){|w| "_#{w.downcase}"} 
    when [0, 2]
      puts line.gsub(/[A-Z]/){|w| "_#{w}"}.upcase
    when [1, 0]
      puts line.gsub(/_./){|w| w[1].capitalize}
    when [1, 2]
      puts line.upcase
    when [2, 0]
      puts line.gsub(/_./){|w| w[1].downcase}.swapcase
    when [2, 1]
      puts line.downcase  
  end
end   

convert(gets.split.map(&:to_i), gets.chomp)



__END__

2 0
USER_ID

userId

2 1
USER_USER_ID
user_user_id

0 1
yaBaDaBaDoo
ya_ba_da_ba_doo

0 2
yaBaDaBaDoo
YA_BA_DA_BA_DOO

1 0
red_chilly_monster
redChillyMonster 

1 2
red_chilly_monster
RED_CHILLY_MONSTER
