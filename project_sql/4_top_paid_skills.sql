/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
  helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    sd.skills,
    ROUND(AVG(jp.salary_year_avg),2) AS average_salary
FROM skills_dim sd

INNER JOIN skills_job_dim sj ON sd.skill_id = sj.skill_id
INNER JOIN job_postings_fact jp ON sj.job_id = jp.job_id
WHERE jp.job_title_short = 'Data Analyst' AND jp.job_location ='Anywhere' AND jp.salary_year_avg IS NOT NULL

GROUP BY sd.skills
ORDER BY average_salary DESC
LIMIT 50
