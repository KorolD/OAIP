alter table parents add town_ID int, foreign key (town_ID) references towns_enum (ID)