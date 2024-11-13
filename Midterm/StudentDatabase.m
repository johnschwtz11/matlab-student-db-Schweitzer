classdef StudentDatabase
    properties
        students = Student.empty(1,0); % Initialize as an empty array of Student objects
    end
    
    methods
        % Method to add a new student to the database
        function obj = addStudent(obj, student)
            obj.students = [obj.students, student]; % Add the new student to the array
        end
        
        % Method to find a student by ID
        function student = findStudentById(obj, student_id)
            student = []; % Initialize an empty array to store the result
            for i = 1:length(obj.students)
                if strcmp(obj.students(i).student_id, student_id)
                    student = obj.students(i); % Return the student if ID matches
                    break;
                end
            end
            if isempty(student)
                disp('Student not found.'); % if user enters id that does not belong to a student
            end
        end
        
        % Method to save database to a .mat file
        function saveToFile(obj, filename)
            save(filename, 'obj'); % Save the database object to a .mat file
        end
        
        % Method to load database from a .mat file
        function obj = loadFromFile(obj, filename)
            loaded_data = load(filename);
            obj = loaded_data.obj; % Load the database object
        end
        
        % Method to get a list of students by major
        function students_by_major = getStudentsByMajor(obj, major)
            % Find all students with the given major
            students_by_major = obj.students(strcmp({obj.students.major}, major));
        end
    end
end

