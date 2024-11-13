% Author Name: John Schweitzer
% Email: schwei87@rowan.edu
% Course: MATLAB Programming - Fall 2024
% Assignment: Midterm
% Task: Student Database
% Date: 11/13/24
clear;
clc;

try
    % ask user how many students do you want to enter
    fprintf('How many students do you want to enter? ');
    num_students = input('');

    % Number of students must be positive integer
    if ~isnumeric(num_students) || num_students <= 0 || mod(num_students, 1) ~= 0
        error('Please enter a positive integer for the number of students.'); % error if not positive integer
    end
    
    % Initialize an empty StudentDatabase
    db = StudentDatabase();  % Create an empty StudentDatabase object

    % Collect student data from user input
    for i = 1:num_students
        fprintf('Enter information for Student %d:\n', i);
        
        % Get student info from user input
        student_id = input('Student ID: ', 's');
        first_name = input('First Name: ', 's');
        last_name = input('Last Name: ', 's');
        age = input('Age: ');
        gpa = input('GPA: ');
        major = input('Major: ', 's');
        
        % age must be positive integer
        if ~isnumeric(age) || age <= 0 || mod(age, 1) ~= 0
            error('Age must be a positive integer.'); % error if not positive integer
        end
        % gpa must be between 0 and 4
        if ~isnumeric(gpa) || gpa < 0 || gpa > 4
            error('GPA must be between 0.0 and 4.0.'); % error if not in range
        end
        
        % Create a new Student object and add it to the database
        student = Student(student_id, first_name, last_name, age, gpa, major);
        db = db.addStudent(student);  % Add student to the database
        
        fprintf('\n');  % blank line to space out
    end

    % Check if the data is being added
    disp('Student data successfully collected:');
    disp(db.students);  % Display the data collected

    % Ask if the user wants to search for a student by ID
    search_choice = input('Do you want to search for a student by ID? (y/n): ', 's'); % user must answer y for yes or n for no
    
    if strcmpi(search_choice, 'y') % if user enters y
        % Search for a student by ID
        search_id = input('Enter the Student ID to search for: ', 's');
        student = db.findStudentById(search_id);  % Call the findStudentById function

        % Display student information if found
        if ~isempty(student)
            student.displayInfo();  % Display the student's information
        end
    end

    % Ask if the user wants to see a list of students by major
    major_choice = input('Do you want to see a list of students by major? (y/n): ', 's'); % user must enter y for yes or n for no
    
    if strcmpi(major_choice, 'y') % if user enters y
        % Display list of majors
        majors = unique({db.students.major});
        
        % Ask the user to select a major
        disp('Select a major from the following list:');
        disp(majors);
        selected_major = input('Enter the major: ', 's'); % user must enter a major from the list of majors
        
        % Display students by the selected major
        students_by_major = db.getStudentsByMajor(selected_major);
        
        if isempty(students_by_major)
            disp(['No students found in the major: ', selected_major]); % if user enters a major not in the list of majors
        else
            fprintf('\nStudents in the major %s:\n', selected_major); % if user enters a major on the list of majors
            for i = 1:length(students_by_major)
                students_by_major(i).displayInfo();  % Display information of each student
                fprintf('\n');
            end
        end
    end

    % Visualizations
    % GPA Distribution Histogram
    gpa_values = [db.students.gpa]; % Extract GPA values from student data
    figure('Position', [100, 100, 800, 600]); % Create a new figure with a specified size
    subplot(3, 1, 1); % Create the first subplot
    histogram(gpa_values, 'BinWidth', 0.5, 'FaceColor', [0.678, 0.847, 0.902]); % Light blue
    title('GPA Distribution', 'Interpreter', 'none'); 
    xlabel('GPA', 'Interpreter', 'none');
    ylabel('Frequency', 'Interpreter', 'none');
    grid on;

    % Save the GPA Distribution as a PNG
    saveas(gcf, 'gpa_distribution.png');
    close(gcf); % Close the figure to prepare for the next plot

    % Average GPA by Major
    majors = unique({db.students.major}); % List of unique majors
    average_gpa = arrayfun(@(major) mean([db.students(strcmp({db.students.major}, major)).gpa]), majors); % Compute avg GPA for each major

    figure('Position', [100, 100, 800, 600]); % Create a new figure for the bar plot
    subplot(3, 1, 2); % Create the second subplot
    bar(average_gpa, 'FaceColor', [0.5, 0.5, 0.5]); % Gray color for bars
    set(gca, 'XTickLabel', majors, 'XTick', 1:length(majors)); % Set x-axis labels to majors
    title('Average GPA by Major', 'Interpreter', 'none');
    xlabel('Major', 'Interpreter', 'none');
    ylabel('Average GPA', 'Interpreter', 'none');
    grid on;

    % Save the Average GPA by Major plot as a PNG
    saveas(gcf, 'average_gpa_by_major.png');
    close(gcf); % Close the figure to prepare for the next plot

    % Age Distribution Histogram
    age_values = [db.students.age]; % Extract age values from student data
    figure('Position', [100, 100, 800, 600]); % Create a new figure for the age distribution
    subplot(3, 1, 3); % Create the third subplot
    histogram(age_values, 'BinWidth', 1, 'FaceColor', [0.565, 0.933, 0.565]); % Light green
    title('Age Distribution', 'Interpreter', 'none');
    xlabel('Age', 'Interpreter', 'none');
    ylabel('Frequency', 'Interpreter', 'none');
    grid on;

    % Save the Age Distribution plot as a PNG
    saveas(gcf, 'age_distribution.png');
    close(gcf); % Close the figure

catch ME
    % Error handling
    disp(['Error: ', ME.message]);
end
