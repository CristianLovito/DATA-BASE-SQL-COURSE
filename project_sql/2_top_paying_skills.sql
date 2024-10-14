/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for there roles
- Why? it provides a detailed look at which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,
        salary_year_avg,
        c.name company_name
    FROM job_postings_fact j
    LEFT JOIN  company_dim AS c
        ON j.company_id = c.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    tj.*,
    sd.skills
FROM top_paying_jobs tj

INNER JOIN skills_job_dim AS sj ON tj.job_id = sj.job_id
INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id

ORDER BY salary_year_avg DESC