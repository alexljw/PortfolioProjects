SELECT *
FROM Portfolio_CovidAnalysis..CovidDeaths
ORDER BY location, date


SELECT *
FROM Portfolio_CovidAnalysis..CovidVaccinations
ORDER BY location, date


SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Portfolio_CovidAnalysis..CovidDeaths
where continent is not null
ORDER BY location, date

-- Looking at Total Cases vs Total Deaths
-- Likelihood of dying after contracting Covid-19 in Singapore
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS 'DeathPercentage'
FROM Portfolio_CovidAnalysis..CovidDeaths
WHERE location = 'Singapore'
ORDER BY location, date

-- Total Cases vs Population
-- Percentage of Cases in Singapore
SELECT location, date, population, total_cases, (total_cases/population)*100 AS 'CasesPercentage'
FROM Portfolio_CovidAnalysis..CovidDeaths
WHERE location = 'Singapore'
ORDER BY location, date

-- Country with highest cases to population
SELECT location, population, MAX(total_cases) AS 'TotalCases', MAX((total_cases/population))*100 AS 'CasesPercentage'
FROM Portfolio_CovidAnalysis..CovidDeaths
where continent is not null
GROUP BY location, population
ORDER BY CasesPercentage DESC

-- Countries with Highest Death Percentage per Population
SELECT location, population, MAX(cast(total_deaths as int)) AS 'TotalDeaths', MAX((total_deaths/population))*100 AS 'DeathPercentage'
FROM Portfolio_CovidAnalysis..CovidDeaths
where continent is not null
GROUP BY location, population
ORDER BY DeathPercentage DESC

-- Country with Highest Death Count
SELECT location, MAX(cast(total_deaths as int)) AS 'TotalDeaths'
FROM Portfolio_CovidAnalysis..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeaths DESC

-- Breaking things down by Continent

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM Portfolio_CovidAnalysis..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global Numbers by Date
 SELECT date, sum(new_cases) AS GlobalNewCases, SUM(cast(new_deaths as int)) AS GlobalNewDeaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
FROM Portfolio_CovidAnalysis..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1

-- Global Numbers in Total
SELECT SUM(population) as GlobalPopulation, SUM(total_cases) as TotalGlobalCases, SUM(total_cases)/SUM(population) AS PercentOfCases, SUM(cast(total_deaths as bigint)) AS TotalGlobalDeaths, SUM(cast(total_deaths as bigint))/SUM(population) AS GlobalDeathPercent, sum(new_cases) AS GlobalNewCases, SUM(cast(new_deaths as int)) AS GlobalNewDeaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
FROM Portfolio_CovidAnalysis..CovidDeaths
WHERE continent is not null

