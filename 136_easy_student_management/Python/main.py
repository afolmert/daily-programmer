#!/usr/bin/python3

def calculate_average(input):

    lines = [line.strip() for line in input.strip().splitlines()]

    students_count = int(lines[0].split(" ")[0])
    notes_per_student_count = int(lines[0].split(" ")[1])
    notes_count = students_count * notes_per_student_count

    all_notes = 0
    student_notes = {}
    students = []

    for line in lines[1:]:
        elems = line.strip().split(" ")
        student_notes[elems[0]] = sum(int(elem) for elem in elems[1:])
        students.append(elems[0])

    all_notes = sum(student_notes.values())

    notes_avg = round(all_notes / notes_count, 2)
    print(notes_avg)
    for student in students:
        student_avg = round(student_notes[student] / notes_per_student_count, 2)
        print(student + " " + str(student_avg))




def main():
    input = """
    3 5
    JON 19 14 15 15 16
    JEREMY 15 11 10 15 16
    JESSE 19 17 20 19 18
    """

    calculate_average(input)



main()
