from rest_framework import serializers
from .models import Assignment, Submission

class AssignmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assignment
        fields = ['id', 'course', 'title', 'description', 'instructions', 'due_date', 'total_marks', 'created_at']

class SubmissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Submission
        fields = ['id', 'assignment', 'student', 'submission_text', 'submission_file', 'status', 'marks_obtained', 'feedback', 'submitted_at', 'graded_at']
