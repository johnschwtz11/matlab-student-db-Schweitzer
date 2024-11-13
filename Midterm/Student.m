classdef Student
    properties
        student_id = ""
        first_name = ""
        last_name = ""
        age = 0
        gpa = 0
        major = ""
    end
    
    methods
        % Constructor method to create a student object
        function obj = Student(student_id, first_name, last_name, age, gpa, major)
            % Validate age and GPA
            if age < 18 || age > 50 % age must be between 18 and 50
                error('Age must be between 18 and 50.'); % error if user enters number outside of range
            end
            if gpa < 0.0 || gpa > 4.0 % gpa must be between 0 and 4
                error('GPA must be between 0.0 and 4.0.'); % error if user enters number outside of range
            end
            
            obj.student_id = student_id;
            obj.first_name = first_name;
            obj.last_name = last_name;
            obj.age = age;
            obj.gpa = gpa;
            obj.major = major;
        end
        
        % Method to display student information
        function displayInfo(obj)
            fprintf('Student ID: %s\n', obj.student_id);
            fprintf('Name: %s %s\n', obj.first_name, obj.last_name);
            fprintf('Age: %d\n', obj.age);
            fprintf('GPA: %.2f\n', obj.gpa);
            fprintf('Major: %s\n', obj.major);
        end
        
        % Method to update GPA
        function obj = updateGPA(obj, new_gpa)
            if new_gpa < 0.0 || new_gpa > 4.0
                error('GPA must be between 0.0 and 4.0.');
            end
            obj.gpa = new_gpa;
        end
        
        % Method to update Age
        function obj = updateAge(obj, new_age)
            if new_age < 18 || new_age > 120
                error('Age must be between 18 and 120.');
            end
            obj.age = new_age;
        end
    end
end
