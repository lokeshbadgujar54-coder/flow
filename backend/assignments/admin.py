from django.contrib import admin
from .models import Assignment, Submission

@admin.register(Assignment)
class AssignmentAdmin(admin.ModelAdmin):
    list_display = ['title', 'course', 'due_date', 'total_marks', 'created_at']
    list_filter = ['course', 'due_date', 'created_at']
    search_fields = ['title', 'description']

@admin.register(Submission)
class SubmissionAdmin(admin.ModelAdmin):
    list_display = ['student', 'assignment', 'status', 'marks_obtained', 'submitted_at']
    list_filter = ['status', 'submitted_at']
    search_fields = ['student__username', 'assignment__title']
