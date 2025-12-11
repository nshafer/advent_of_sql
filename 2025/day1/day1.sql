select trim(lower(raw_wish)) as wish, count(*)
from wish_list
group by 1
order by 2 desc
