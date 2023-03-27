from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
import mysql.connector

app = FastAPI()

# MySQL connection configuration
db = mysql.connector.connect(
    host='localhost',
    user='root',
    password='password',
    database='student_db'
)
cursor = db.cursor()

# Define Student model
class Student(BaseModel):
    id: int
    name: str
    email: str
    phone: str

# CRUD operations
@app.get('/students', response_model=List[Student])
def read_students():
    cursor.execute('SELECT * FROM students')
    students = []
    for (id, name, email, phone) in cursor:
        students.append(Student(id=id, name=name, email=email, phone=phone))
    return students

@app.get('/students/{student_id}', response_model=Student)
def read_student(student_id: int):
    cursor.execute('SELECT * FROM students WHERE id=%s', (student_id,))
    result = cursor.fetchone()
    if result:
        return Student(id=result[0], name=result[1], email=result[2], phone=result[3])
    else:
        raise HTTPException(status_code=404, detail='Student not found')

@app.post('/students', response_model=Student)
def create_student(student: Student):
    values = (student.id, student.name, student.email, student.phone)
    cursor.execute('INSERT INTO students (id, name, email, phone) VALUES (%s, %s, %s, %s)', values)
    db.commit()
    return student

@app.put('/students/{student_id}', response_model=Student)
def update_student(student_id: int, student: Student):
    values = (student.name, student.email, student.phone, student_id)
    cursor.execute('UPDATE students SET name=%s, email=%s, phone=%s WHERE id=%s', values)
    if cursor.rowcount == 0:
        raise HTTPException(status_code=404, detail='Student not found')
    else:
        db.commit()
        student.id = student_id
        return student

@app.delete('/students/{student_id}')
def delete_student(student_id: int):
    cursor.execute('DELETE FROM students WHERE id=%s', (student_id,))
    if cursor.rowcount == 0:
        raise HTTPException(status_code=404, detail='Student not found')
    else:
        db.commit()
        return {'message': 'Student deleted successfully'}
