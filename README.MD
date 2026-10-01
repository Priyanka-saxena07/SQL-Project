# Introduction

In this project, I analyzed which is most demand skill...

1. What are the top-paying jobs for 'Data Analyst'?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?

Optimal: High demand AND High paying

### 1. Top Paying Data Analyst Jobs
SELECT
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
![Top Paying Roles](<Solution 1.jpg>)

### 2. Skills for Top Paying Jobs
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
![Top Paying job Skills](<Solution 2.jpeg>) 

### 3. In-Demand Skills for Data Analysts
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;
![Top demand skills](<Solution 3.jpeg>)

### 4. Skills Based on Salary
SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10;
![Top paying skills](<Solution 4.jpeg>)

### 5. Most Optimal Skills to Learn
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    demand_count DESC
LIMIT 25;
![most optimal skills](<Solution 5.jpeg>)


# Conclusions

### What I Learned
As a fresher, this was my first end-to-end SQL project and it helped me a lot:

- **Complex Query Crafting:** Learned how to write advanced SQL queries with JOINS and WITH clauses.
- **Data Aggregation:** Got comfortable with GROUP BY, COUNT() and AVG().
- **Analytical Thinking:** Learned how to convert a real-world question into a SQL query.

### Key Insights from Data
1.  **Top-Paying Jobs:** Remote Data Analyst jobs can pay up to $650k, but they require strong skills.
2.  **Most Important Skill:** SQL is the #1 most demanded skill for a Data Analyst.
3.  **High-Paying Niche Skills:** Skills like Solidity, SVN get higher salary but SQL + Python is the best combo for freshers.

### Closing Thoughts
This project was a great learning experience for me as a fresher. I built this project to understand the job market and to improve my SQL skills. I am now more confident in SQL and looking for an entry-level Data Analyst role where I can learn and grow.

