# Tabibu Health Care

## Running the project

- The Tabibu Health Project is a two-part project consisting of a backend developed using Django Rest Framework and an android app developed using Flutter.
- We used Figma to design the Tabibu Health Project. You can access the design at the following link: [Tabibu Health Care](https://www.figma.com/file/wRCK56xCm8XkXLZuZK9oAx/Tabibu-Health-Care?node-id=0%3A1&t=kPS1F67DoLg29e2p-1)  
- We will provide instructions for installing both the backend and Flutter app in the following section;

### Backend
  - Clone the backend using the command `git clone https://github.com/qinyanjuidavid/Tabibu-Health-Care-API.git`
  - Change to the project directory using the command `cd Tabibu-Health-Care-API`
  - Install virtualenv using the command `pip install virtualenv`
  - Create a new virtual environment for the project using the command `python -m venv venv`
  - Activate the virtual environment using the command `.\venv\Scripts\activate`
  - Install the project's dependencies using the command `pip install -r requirements.txt`
  - Collect the project's static files using the command `python manage.py collectstatic`
  - Create database migrations using the command `python manage.py makemigrations`
  - Apply the migrations to the database using the command `python manage.py migrate`
  - Create a superuser account using the command `python manage.py createsuperuser`
 - Run the project using the command `python manage.py runserver 8000`
 - Access the Admin Dashboard at [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/) using the credentials from the previous step

### Flutter App

  - Install Android Studio
  - Clone the Flutter App using the command using the command `git clone https://github.com/qinyanjuidavid/Tabibu-Health-Care-App.git`
  - Run the flutter app from Android Studio

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

- Tabibu Health Care is aligned with SDG 3, which aims to ensure healthy lives and promote well-being for all. Specifically, we are working towards Target 3.8 of SDG 3, which seeks to achieve universal health coverage, including financial risk protection, access to quality essential healthcare services, and access to safe, effective, quality, and affordable essential medicines and vaccines for all.
- By utilizing technology, our project seeks to improve access to quality and affordable healthcare services in East Africa by 2030. Our platform enables users to access medical care conveniently and thus eliminating the need to queue. In addition, users will have the ability to compare the prices of medical services across different facilities, empowering them to make informed decisions about their healthcare options
- Through our project, we hope to reduce financial barriers to healthcare and enable more people to access the medical care they need. By doing so, we believe we can contribute to improving health outcomes and promoting well-being for individuals and communities across the region.
  

### SDG 8: Decent Work and Economic Growth

- Tabibu Health Care is committed to promoting sustainable and inclusive economic growth in our region, in alignment with SDG 8. Our goal is to support Target 8.3 of SDG 8 which focuses on the growth of micro-, small-, and medium-sized healthcare enterprises.

- Through the use of the Tabibu Health Care Flutter App, users can easily find the nearest healthcare clinics and facilities, thus helping to promote the formalization and growth of small businesses in the healthcare industry. By doing so, we hope to create more job opportunities and encourage entrepreneurship and innovation in the health sector of our region.

### SDG 10: Reduced Inequalities

- The Tabibu Health Care Project contributes to SDG 10 by leveraging technology to improve access to quality and affordable healthcare services in East Africa. Specifically, the project aims to empower and promote the social, economic, and political inclusion of all, irrespective of age, sex, disability, race, ethnicity, origin, religion, or economic or other status, as outlined in Target 10.2 of SDG 10.

- Through the Tabibu Health Care Project's app, users can easily access suggestions of the nearest clinics around them, regardless of their location or socio-economic status. This feature helps to address economic inequalities in healthcare by enabling small clinics to reach more patients and avoid closing due to a lack of business. By improving access to healthcare services, the Tabibu Health Project aims to reduce inequalities in healthcare access and outcomes, thus promoting social and economic inclusion for all.

- The Tabibu Health Project believes that providing equal access to healthcare services can create a more just and equitable society that benefits everyone. By contributing to SDG 10, the project is working towards a future where access to quality and affordable healthcare services is a universal right, not a privilege.


## Scalability

- The Tabibu Health Care app is an app with endless possibilities. Our plan is to develop a Javascript-based frontend that will enable medical practitioners, including doctors, nurses, receptionists, lab technicians, and pharmacists, to manage their clinic's information efficiently. With this app, we will be able to collect a wide range of information, including images of diseases and treatments used, which we will use to train a machine learning model. This model will help predict diseases that patients may suffer from and recommend better treatments.

- We also intend to enable users to use their National Health Insurances to pay for medical services, but this will require a collaborative effort between insurance companies and the Tabibu Health Care team since most insurance companies in Kenya do not currently allow users to use their insurance in small clinics.

- Our ultimate goal is to scale Tabibu Health Care to become the default platform used by all medical facilities in East Africa. By doing so, we hope to revolutionize the healthcare industry in the region and make quality healthcare accessible to everyone.

## App Testing

- To ensure that our solution meets the needs of real users, we took several steps to gather feedback and iterate on our design.
- First, during the design phase, we consulted with medical students from other to get feedback on what features medical practitioners would expect from the app. One piece of feedback we received was the need for an admin panel that would allow medical practitioners to upload images, especially for cancer screening purposes.

- Next, we created a dummy UI and gathered feedback from mentors on what features we should integrate. Some of the feedback we received included the ability for patients to get suggestions on the nearest medical facilities and to compare prices of medical services before booking an appointment.

- Finally, we tested the app with real data by showing it to clinical officers at the Taita Taveta university health unit. Although we faced a challenge since our backend was not hosted, we were still able to show them the flow of the app using an emulator. The clinical officers found the app easy to use and expressed interest in starting to use it, as they currently use paper files to record patient information, which can quickly become cumbersome.

- Based on the feedback we received from users, we integrated features that allow patients to find nearby medical facilities and compare prices of medical services. 

## Technology

- Tabibu Health Care is a comprehensive healthcare application that utilizes a range of cutting-edge technologies. To begin with, the design of the app was created using Figma, a popular interface design tool that allows for the creation of high-fidelity prototypes.

- The app was developed for the Android platform using Flutter, a mobile app development framework that allows for the creation of high-quality native applications for both Android and iOS devices. Flutter was chosen for its ease of use, as well as its ability to deliver fast performance and beautiful UI design.

- The API for Tabibu Health Care was developed using Django Rest Framework, a powerful and flexible toolkit for building Web APIs. This framework allowed for the efficient development of a secure and scalable API that can be used to manage patient data, medical records, and other important information.

- Overall, Tabibu Health Care is a state-of-the-art application that leverages the latest technologies to provide users with a comprehensive healthcare solution. From the design and development to the API and backend, each component has been carefully chosen to ensure that the app delivers the best possible experience for both patients and medical professionals.

## Google Technology Overview
### Firebase Auth
- Tabibu Health Care is a project that utilizes Firebase Auth to enable user registration and login. With Firebase Auth, users can register and sign in using their Google account, making the process quick and convenient. This allows users to easily register and access the app's features, streamlining their experience.
- The following dependancies were used in `pubspec.yaml`;
```
 firebase_core: ^2.4.0
 firebase_auth: ^4.2.1
 google_sign_in: ^5.4.2
```

<p float="left">
<img src="https://user-images.githubusercontent.com/49823575/229349416-fda81b53-8515-4675-9792-dc61bde6572c.png" data-canonical-src="https://user-images.githubusercontent.com/49823575/229349416-fda81b53-8515-4675-9792-dc61bde6572c.png" width="330" height="450">
<img src="https://user-images.githubusercontent.com/49823575/229349723-9165534f-7a4a-47b5-8b0e-2118d3c58f6e.png" data-canonical-src="https://user-images.githubusercontent.com/49823575/229349723-9165534f-7a4a-47b5-8b0e-2118d3c58f6e.png" width="330" height="450"></p>

### Google Cloud
- we leveraged Google Cloud to create the Google Maps API, which we integrated into our application. By utilizing this API, we were able to implement Google Maps within our app, allowing users to easily locate clinics on a map. 
- The following dependancy was used in the `pubspec.yaml`
`google_maps_flutter: ^2.2.1`
- This implementation was done in our `AndroidManifest.xml`
`<meta-data android:name="com.google.android.geo.API_KEY"
               android:value="OUR-API-KEY"/>`
      
<p float="left">
<img src="https://user-images.githubusercontent.com/49823575/229374400-12f465b9-1915-4e78-b8eb-9c5f1ad9429b.png" data-canonical-src="https://user-images.githubusercontent.com/49823575/229374400-12f465b9-1915-4e78-b8eb-9c5f1ad9429b.png" width="330" height="450">
<img src="https://user-images.githubusercontent.com/49823575/229374337-b5f7a25b-9eba-4b3f-82d4-2e7f392c1997.png" data-canonical-src="https://user-images.githubusercontent.com/49823575/229374337-b5f7a25b-9eba-4b3f-82d4-2e7f392c1997.png" width="330" height="450"></p>

### Flutter
- We used Flutter framework and other flutter libraries to develop the overral android app for the Tabibu Health Care.
- We used the below versions of Dart and Flutter;
```
Flutter 3.7.7
Dart 2.19.4
```



