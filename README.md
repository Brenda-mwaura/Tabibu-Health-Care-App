# Tabibu Health Care

## Running the project

- The Tabibu Health Project is a two-part project consisting of a backend developed using Django Rest Framework and an android app developed using Flutter.
- We used Figma to design the Tabibu Health Project. You can access the design at the following link: [Tabibu Health Care](https://www.figma.com/file/wRCK56xCm8XkXLZuZK9oAx/Tabibu-Health-Care?node-id=0%3A1&t=kPS1F67DoLg29e2p-1)  
- We will provide instructions for installing both the backend and Flutter app in the following section;

> ### Backend
>
> - Clone the backend using the command `git clone https://github.com/qinyanjuidavid/Tabibu-Health-Care-API.git`
> - Change to the project directory using the command `cd Tabibu-Health-Care-API`
> - Install virtualenv using the command `pip install virtualenv`
> - Create a new virtual environment for the project using the command `python -m venv venv`
> - Activate the virtual environment using the command `.\venv\Scripts\activate`
> - Install the project's dependencies using the command `pip install -r requirements.txt`
> - Collect the project's static files using the command `python manage.py collectstatic`
> - Create database migrations using the command `python manage.py makemigrations`
> - Apply the migrations to the database using the command `python manage.py migrate`
> - Create a superuser account using the command `python manage.py createsuperuser`
> - Run the project using the command `python manage.py runserver 8000`
> - Access the Admin Dashboard at [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/) using the credentials from the previous step

>### Flutter App
>
> - Install Android Studio
> - Clone the Flutter App using the command using the command `git clone https://github.com/qinyanjuidavid/Tabibu-Health-Care-App.git`
> - Run the flutter app from Android Studio

## Introduction

- Access to quality medical services is a fundamental right that every individual should have. However, in Kenya, there are several barriers that prevent patients from accessing the medical care they need. 
- According to the World Health Organization(WHO), Kenya has one of the highest patient-to-doctor ratios in the world, with only one doctor per 16,000 people. This means that patients often have to wait for long periods to see a doctor, and the quality of medical services may suffer as a result. 
- In addition, a study by the Kenya Medical Research Institute (KEMRI) found that patients who seek medical attention at public hospitals have to wait for an average of 4 hours before being attended to, with some patients waiting for up to 8 hours. This long wait time is a significant barrier to accessing medical services, and it often leads to patients seeking care from unqualified medical practitioners, or not seeking care at all.
- Furthermore, the lack of a proper appointment booking system in hospitals is another challenge that patients face. This results in patients queuing for long hours just to book an appointment, which can be a significant problem for handicapped individuals. According to a study by the Kenya Medical Practitioners and Dentists Board, there is an average of 70 patients per doctor in public hospitals, making it difficult for doctors to provide quality medical services.
- In addition, many patients are unaware of the small clinics around them and end up going to public hospitals, where the queues are long and waiting times can be deadly. In fact, according to a study by the Kenya National Bureau of Statistics, over 50% of patients who die while seeking medical services in public hospitals do so while waiting in line
- Moreover, patients in Kenya face additional challenges due to the lack of access to their medical records. The current system used in hospitals is paper-based, and hospitals retain all patient records in a file. This makes it difficult for patients to transfer their medical records to other hospitals or clinics, and it can be a tedious process for hospitals to manage these records, leading to lost or misplaced files. Additionally, there are no public hospitals in rural areas, and many small clinics in these regions are unknown to patients. This forces patients to travel long distances to access medical services, which can be a burden for those with limited resources.
- Lastly, many small clinics in Kenya close each year due to lack of patients. This is a significant concern for hospitals, clinics, and patients, as it can lead to a decrease in the availability of medical services in certain areas.

## Problem

- Patients in Kenya face multiple challenges when seeking medical care, including long queues and limited access to quality medical services at public hospitals, lack of access to medical records, and limited awareness of small clinics in their localities. These problems lead to delays in treatment, misdiagnosis, and potential loss of life, as well as added costs and inconvenience for patients who must travel long distances to receive medical care. 
- Furthermore, clinics struggle to attract patients, with many closing each year due to lack of demand. 

## Solution

- Tabibu Health Care is a solution that bridges the gap between patients and medical services in Kenya. "Tabibu" is a Swahili name that means "healer," which is an innovative project that leverages Python, Flutter, and other Google technologies.
- With Tabibu, users can easily locate medical facilities near them and book appointments from the comfort of their homes. The app also provides users with a detailed overview of the medical services offered by each facility, as well as their pricing, allowing them to make informed decisions about their healthcare.
- Our goal is to enable Kenyans to access quality and reliable medical services without hassle.

## SDGs

### SDG 3: Good Health and Well-being

- Our project is aligned with SDG 3, which aims to ensure healthy lives and promote well-being for all. Specifically, we are working towards Target 3.8 of SDG 3, which seeks to achieve universal health coverage, including financial risk protection, access to quality essential healthcare services, and access to safe, effective, quality, and affordable essential medicines and vaccines for all.
- By utilizing technology, our project seeks to improve access to quality and affordable healthcare services in East Africa by 2030. Our platform enables users to access medical care conveniently and thus eliminating the need to queue. In addition, users will have the ability to compare the prices of medical services across different facilities, empowering them to make informed decisions about their healthcare options
- Through our project, we hope to reduce financial barriers to healthcare and enable more people to access the medical care they need. By doing so, we believe we can contribute to improving health outcomes and promoting well-being for individuals and communities across the region.
  

### SDG 8: Decent Work and Economic Growth

- Our project is aligned with SDG 8, which aims to promote sustained, inclusive, and sustainable economic growth, full and productive employment, and decent work for all. Specifically, we are working towards Target 8.3 of SDG 8, which seeks to promote development-oriented policies that support productive activities, decent job creation, entrepreneurship, creativity, and innovation, and encourage the formalization and growth of micro-, small-, and medium-sized enterprises.

- By leveraging technology, our project aims to stimulate economic growth in our region by 2030. Our app provides users with suggestions for the nearest clinics, helping small clinics to stay open by attracting more patients. This, in turn, will create more job opportunities and promote entrepreneurship and innovation within the healthcare industry.


## Scalability


## App Testing


## Technology


## Google Technology Overview
