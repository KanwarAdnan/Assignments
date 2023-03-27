from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
from pymongo import MongoClient
from bson.objectid import ObjectId

app = FastAPI()

# MongoDB connection configuration
client = MongoClient('mongodb://localhost:27017/')
db = client['student_db']
students_collection = db['students']

# Define Student model
class Student(BaseModel):
    id: str = None
    name: str
    email: str
    phone: str

# CRUD operations
@app.get('/students', response_model=List[Student])
def read_students():
    students = []
    for student in students_collection.find():
        student['id'] = str(student['_id'])
        students.append(Student(**student))
    return students

@app.get('/students/{student_id}', response_model=Student)
def read_student(student_id: str):
    student = students_collection.find_one({'_id': ObjectId(student_id)})
    if student:
        student['id'] = str(student['_id'])
        return Student(**student)
    else:
        raise HTTPException(status_code=404, detail='Student not found')

@app.post('/students', response_model=Student)
def create_student(student: Student):
    student_dict = student.dict()
    del student_dict['id']
    result = students_collection.insert_one(student_dict)
    student.id = str(result.inserted_id)
    return student

@app.put('/students/{student_id}', response_model=Student)
def update_student(student_id: str, student: Student):
    student_dict = student.dict()
    del student_dict['id']
    result = students_collection.update_one({'_id': ObjectId(student_id)}, {'$set': student_dict})
    if result.modified_count == 0:
        raise HTTPException(status_code=404, detail='Student not found')
    else:
        student.id = student_id
        return student

@app.delete('/students/{student_id}')
def delete_student(student_id: str):
    result = students_collection.delete_one({'_id': ObjectId(student_id)})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail='Student not found')
    else:
        return {'message': 'Student deleted successfully'}
