select e.name, e.surname, t.name as 'town' from enrollees e inner join towns_enum t on t.ID=e.town_ID