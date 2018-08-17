require_relative "../config/environment.rb"

class Student
  attr_accessor :name 
  attr_accessor :grade
  attr_reader :id 
  
  def initialize(name, grade)
    @name = name 
    @grade = grade
  end
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end
  
  def save
    if self.if
      self.update
    else
      sql = <<-SQL
        INSERT INTO students(name, grade) VALUES(?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.grade)
    end
  end
  
  def self.create(name, grade)
    student = self.new(name, grade)
    student.save
    student
  end


end
