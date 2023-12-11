-- DSQ - 2002
-- Week 2 - Mandatory Project

use ig_clone;

-- 1.	Create an ER diagram or draw a schema for the given database.

-- I have sent ER diagram in pdf format.

-- 2.	We want to reward the user who has been around the longest, Find the 5 oldest users.

select * from users order by created_at limit 5;


-- 3.	To understand when to run the ad campaign, figure out the day of the week most users register on? 

select DAYNAME(created_at) as day, count(*) as total from users group by day
order by total desc limit 2;


-- 4.	To target inactive users in an email ad campaign, find the users who have never posted a photo.

select u.username from users u left join photos p on  u.id = p.user_id where p.id is null;


-- 5.	Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?

select u.username, p.id, p.image_url, count(l.user_id) as total from photos p
inner join likes l on l.photo_id=p.id inner join users u on p.user_id = u.id
group by p.id order by total desc limit 1;


-- 6.	The investors want to know how many times does the average user post.

-- total no. of photos / total no. of users

select (select count(*) from photos) / (select count(*) from users) as average;
    
    
-- 7.	A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.


select t.tag_name, count(*) as total from photo_tags pt inner join tags t on pt.tag_id= t.id
group by t.id order by total desc limit 5;


-- 8.	To find out if there are bots, find users who have liked every single photo on the site.

select u.id, u.username, count(u.id) as total_likes_by_user from users u inner join likes l on
u.id = l.user_id group by u.id having total_likes_by_user = (select count(*) from photos);


-- 9.	To know who the celebrities are, find users who have never commented on a photo.

select u.username, c.comment_text from users u left join comments c on u.id = c.user_id group by
u.id having comment_text is null;


-- 10.	Now it's time to find both of them together, find the users who have never commented on any photo
-- or have commented on every photo.

select first_tbl.total1 AS 'No. of users who have never commented', 
second_tbl.total2 AS 'No. of users who comnted on every photos' from
(select count(*) as total1 from (select username,comment_text from users left join comments
 on users.id = comments.user_id group by users.id having comment_text is null)
 as total_number_of_users_without_comments) as first_tbl
join
(select count(*) as total2 from (select username,comment_text from users left join comments
 on users.id = comments.user_id group by users.id having comment_text is not null) 
 as total_number_users_with_comments)as second_tbl




























