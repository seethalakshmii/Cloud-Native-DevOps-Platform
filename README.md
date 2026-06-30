# Cloud-Native DevOps Platform on AWS

A production-ready cloud-native DevOps project that automates infrastructure provisioning, CI/CD, Kubernetes deployments, monitoring, centralized logging, and serverless notifications using AWS services and modern DevOps tools.

---

## 🚀 Features

- Infrastructure provisioning using Terraform
- Containerized Frontend & Backend using Docker
- Amazon EKS Kubernetes deployment
- GitHub Actions Continuous Integration (CI)
- ArgoCD GitOps Continuous Deployment (CD)
- Canary Deployments using Argo Rollouts
- Amazon RDS (MySQL) integration
- AWS Secrets Manager for secure credential management
- AWS Load Balancer Controller & Ingress
- Monitoring with Prometheus & Grafana
- Centralized logging with Loki & Promtail
- Alerting using Alertmanager
- AWS Lambda triggered by Amazon S3 uploads
- Email notifications using Amazon SES

---

## 🛠️ Tech Stack

- **Cloud:** AWS (EKS, ECR, RDS, S3, Lambda, SES, IAM, Secrets Manager)
- **Infrastructure as Code:** Terraform
- **Containerization:** Docker
- **Container Orchestration:** Kubernetes
- **CI/CD:** GitHub Actions, ArgoCD
- **Deployment Strategy:** Argo Rollouts (Canary)
- **Monitoring:** Prometheus, Grafana
- **Logging:** Loki, Promtail
- **Alerting:** Alertmanager
- **Backend:** Python, Flask
- **Frontend:** HTML, CSS, JavaScript, Nginx

---

## 🔄 Project Workflow

1. Provision AWS infrastructure using Terraform.
2. Build and containerize the frontend and backend applications.
3. Push source code to GitHub.
4. GitHub Actions builds, tests, and pushes Docker images to Amazon ECR.
5. ArgoCD synchronizes Kubernetes manifests and deploys the application to Amazon EKS.
6. Argo Rollouts performs Canary deployments with rollback support.
7. AWS Load Balancer Controller exposes the application through an Ingress.
8. Backend stores user data in Amazon RDS and uploads files to Amazon S3.
9. Amazon S3 triggers AWS Lambda on every file upload.
10. AWS Lambda sends email notifications using Amazon SES.
11. Prometheus collects metrics, Grafana visualizes dashboards, Loki stores logs, Promtail collects logs, and Alertmanager generates alerts.

---

## 📄 Documentation

Detailed project reports, implementation steps, setup commands, and architecture are available in the **Documentation/** folder.

- **Day 1** – Application Development & AWS Infrastructure (Terraform)
- **Day 2** – Kubernetes, ArgoCD & GitOps Deployment
- **Day 3** – CI/CD Pipeline, GitHub Actions & Canary Deployment
- **Day 4** – Monitoring, Logging & Alerting
- **Day 5** – Amazon RDS, Serverless Integration & Project Workflow

---

## ✅ Outcome

Successfully implemented a scalable, production-ready cloud-native DevOps platform featuring Infrastructure as Code, Kubernetes orchestration, GitOps-based CI/CD, Canary deployments, monitoring, centralized logging, secure secret management, persistent database integration, and event-driven serverless automation on AWS.
