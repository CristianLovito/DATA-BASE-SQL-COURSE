/*
Answer: Whar are the most optimal skills to learn (aka it's in high demand and high-paying skill)?
- Identify skills in high demand and associated with high average salaries for data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
  offering strategic insights for career development in data analysis
*/

WITH skill_demand AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(jp.job_id) demand_count
    FROM skills_dim sd

    INNER JOIN skills_job_dim sj ON sd.skill_id = sj.skill_id
    INNER JOIN job_postings_fact jp ON sj.job_id = jp.job_id
    WHERE jp.job_title_short = 'Data Analyst' 
    AND jp.job_location ='Anywhere'
    AND jp.salary_year_avg IS NOT NULL

    GROUP BY sd.skill_id
), 

average_salary AS (
    SELECT
        sd.skill_id,
        sd.skills,
        ROUND(AVG(jp.salary_year_avg),2) AS avg_salary
    FROM skills_dim sd

    INNER JOIN skills_job_dim sj ON sd.skill_id = sj.skill_id
    INNER JOIN job_postings_fact jp ON sj.job_id = jp.job_id
    WHERE jp.job_title_short = 'Data Analyst' 
    AND jp.job_location ='Anywhere' 
    AND jp.salary_year_avg IS NOT NULL

    GROUP BY sd.skill_id
)

SELECT 
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    avg_salary
FROM skill_demand

INNER JOIN average_salary ON skill_demand.skill_id = average_salary.skill_id

WHERE demand_count > 10

ORDER BY avg_salary DESC, demand_count DESC

LIMIT 50;


