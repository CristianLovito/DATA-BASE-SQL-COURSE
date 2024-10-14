/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to querry 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieve the top 5 skills with the highest demand in the job market,
  providing insights in to the most valuable skills for job seekers.
*/

SELECT
    sd.skills,
    COUNT(jp.job_id) demand_count
FROM skills_dim sd

INNER JOIN skills_job_dim sj ON sd.skill_id = sj.skill_id
INNER JOIN job_postings_fact jp ON sj.job_id = jp.job_id
WHERE jp.job_title_short = 'Data Analyst' AND jp.job_location ='Anywhere'

GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 5