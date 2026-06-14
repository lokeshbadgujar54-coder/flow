from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from .models import Course, Lesson, Enrollment
from .serializers import CourseSerializer, LessonSerializer, EnrollmentSerializer

class CourseViewSet(viewsets.ModelViewSet):
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    permission_classes = [AllowAny]
    
    def perform_create(self, serializer):
        serializer.save(teacher=self.request.user)
    
    @action(detail=False, methods=['get'])
    def my_courses(self, request):
        if request.user.is_authenticated:
            courses = request.user.courses.all()
            serializer = self.get_serializer(courses, many=True)
            return Response(serializer.data)
        return Response({'error': 'Not authenticated'}, status=status.HTTP_401_UNAUTHORIZED)
    
    @action(detail=True, methods=['post'])
    def enroll(self, request, pk=None):
        course = self.get_object()
        student = request.user
        
        enrollment, created = Enrollment.objects.get_or_create(student=student, course=course)
        
        if created:
            serializer = EnrollmentSerializer(enrollment)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({'message': 'Already enrolled'}, status=status.HTTP_200_OK)

class LessonViewSet(viewsets.ModelViewSet):
    queryset = Lesson.objects.all()
    serializer_class = LessonSerializer
    permission_classes = [AllowAny]
    
    def get_queryset(self):
        course_id = self.request.query_params.get('course_id')
        if course_id:
            return Lesson.objects.filter(course_id=course_id)
        return Lesson.objects.all()

class EnrollmentViewSet(viewsets.ModelViewSet):
    queryset = Enrollment.objects.all()
    serializer_class = EnrollmentSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        return Enrollment.objects.filter(student=self.request.user)
