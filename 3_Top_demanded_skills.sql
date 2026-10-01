--What are the most in-demand skills for my role?
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

--Solution 3
[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  },
  {
    "skills": "r",
    "demand_count": "2142"
  },
  {
    "skills": "sas",
    "demand_count": "1866"
  },
  {
    "skills": "looker",
    "demand_count": "868"
  },
  {
    "skills": "azure",
    "demand_count": "821"
  },
  {
    "skills": "powerpoint",
    "demand_count": "819"
  }
]