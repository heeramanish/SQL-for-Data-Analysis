CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

INSERT INTO job_applied (
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
VALUES (1,
        TO_DATE('05-04-2026','DD-MM-YYYY'),
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'),
        (2,
        TO_DATE('04-04-2026','DD-MM-YYYY'),
        true,
        'resume_02.pdf',
        true,
        'cover_letter_02.pdf',
        'submitted'),
        (3,
        TO_DATE('03-04-2026','DD-MM-YYYY'),
        true,
        'resume_03.pdf',
        false,
        'cover_letter_03.pdf',
        'rejected'),
        (4,
        TO_DATE('02-04-2026','DD-MM-YYYY'),
        false,
        'resume_04.pdf',
        true,
        'cover_letter_04.pdf',
        NULL),
        (5,
        TO_DATE('01-04-2026','DD-MM-YYYY'),
        true,
        'resume_05.pdf',
        true,
        'cover_letter_05.pdf',
        'submitted'),
        (6,
        TO_DATE('30-03-2026','DD-MM-YYYY'),
        true,
        'resume_06.pdf',
        false,
        'cover_letter_06.pdf',
        'submitted');


        SELECT
            *
        FROM job_applied;

        ALTER TABLE job_applied
        ADD contact VARCHAR(50);

        UPDATE job_applied
        SET contact = 'Mac Shah'
        WHERE job_id = 2;

        UPDATE job_applied
        SET contact = 'Eric Singh'
        WHERE job_id = 1;

        UPDATE job_applied
        SET contact = 'Goh David'
        WHERE job_id = 3;

        UPDATE job_applied
        SET contact = 'Vah Xi'
        WHERE job_id = 4;

        UPDATE job_applied
        SET contact = 'Ryan Roy'
        WHERE job_id = 6;

        UPDATE job_applied
        SET contact = 'Eric Singh'
        WHERE job_id = 1;