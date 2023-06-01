select * 
from portfolioproject..CovidDeaths$
where continent is not null
order by 3,4

select * 
from portfolioproject..CovidVaccinations$
--order by 3,4

select location, date, total_cases,new_cases, total_deaths, population
from portfolioproject..coviddeaths$
order by 1,2

--looking at totat cases vs total deaths
--shows the likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths,(cast(total_deaths as int) /total_cases)*100 as DeathPercentage
from portfolioproject..coviddeaths$
order by 1,2

--looking at total cases vs population
--show us what percentages has got covid
select location, date, total_cases,population, (total_cases/population)*100 as PercentPopulationInfected
from portfolioproject..coviddeaths$
--where location like '%nigeria%'
order by 1,2

--looking at countries with highest infection rate compared to population
select location,population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from portfolioproject..coviddeaths$
--where location like '%nigeria%'
group by location, population
order by PercentPopulationInfected desc

--showing the countries with the highest death count per population
select location,max(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..coviddeaths$
--where location like '%nigeria%'
where continent is not null
group by location, population
order by TotalDeathCount desc

--breaking things down by continent
select continent,max(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..coviddeaths$
--where location like '%nigeria%'
where continent is not null
group by continent
order by TotalDeathCount desc

--showing the continent with the highest death count per population
select sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..coviddeaths$
--where location like '%nigeria%'
where continent is not null
--group by date
order by 1,2

--looking at total population vs vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from portfolioproject..CovidDeaths$ dea
join portfolioproject..CovidVaccinations$ vac
 on dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null
 order by 2,3

 create view TotalDeathCount as
 select location,max(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..coviddeaths$
--where location like '%nigeria%'
where continent is not null
group by location, population
--order by TotalDeathCount desc

select *
from TotalDeathCount
