select c.official_category,
       sum(i.quantity) as total_usable_snowballs
from snowball_categories c
         left join snowball_inventory i on i.category_name = c.official_category
where i.quantity > 0
  and i.status = 'ready'
group by 1
order by 2
limit 10