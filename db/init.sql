CREATE TYPE books_borrowing_state as ENUM ('In use', 'returned', 'lost', 'not returned on time');

CREATE TABLE IF NOT EXISTS public.Readers (
    ticket_id INTEGER PRIMARY KEY,
    first_name VARCHAR(40) not null,
    last_name VARCHAR(40) not null, 
    patronymic VARCHAR(40),
    address VARCHAR(255),
    phone_number VARCHAR(20) not null
);

CREATE TABLE IF NOT EXISTS public.Publishing_houses (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) not null,
    city VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS public.Books (
    id INTEGER PRIMARY KEY,
    title VARCHAR(100) not null,
    author VARCHAR(60) not null, 
    publishing_house_id INTEGER not null,
    year_of_publication INTEGER not null,
    volume_in_pages INTEGER not null,
    price NUMERIC(6, 2) not null,
    num_of_copies_in_fund INTEGER not null,

    FOREIGN KEY (publishing_house_id) REFERENCES Publishing_houses (id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS public.Libraries (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) not null,
    address VARCHAR(255),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS public.Books_borrowing (
    id INTEGER PRIMARY KEY,
    readers_ticket_id INTEGER not null,
    book_id INTEGER not null, 
    library_id INTEGER not null,
    start_date DATE not null,
    last_date_to_return DATE not null,
    status books_borrowing_state,

    FOREIGN KEY (readers_ticket_id) REFERENCES Readers (ticket_id) ON DELETE SET NULL,
    FOREIGN KEY (book_id) REFERENCES Books (id) ON DELETE SET NULL,
    FOREIGN KEY (library_id) REFERENCES Libraries (id) ON DELETE SET NULL
);