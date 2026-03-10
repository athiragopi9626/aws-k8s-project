# Cloud Native Infrastructure Platform

This project demonstrates a cloud-native infrastructure platform built using Infrastructure as Code and Kubernetes.

## Technologies

- AWS
- Terraform
- Kubernetes
- GitHub Actions
- Prometheus
- Grafana

## Architecture

The platform provisions AWS infrastructure using Terraform and deploys containerised workloads on Kubernetes.

Components include:

- VPC networking
- EKS Kubernetes cluster
- Kubernetes deployments and services
- Observability stack (Prometheus + Grafana)
- CI/CD pipeline using GitHub Actions

## Deployment Workflow

1. Terraform provisions infrastructure
2. Kubernetes manifests deploy workloads
3. GitHub Actions automates deployment
4. Observability stack monitors cluster health

## Repository Structure

- terraform/ – infrastructure provisioning
- kubernetes/ – cluster deployments
- .github/workflows – CI/CD pipelines
- docs/ – architecture documentation

## Observability

Monitoring stack includes:

- Prometheus (metrics)
- Grafana (dashboards)

## Purpose

This repository demonstrates DevOps and Infrastructure Engineering practices including:

- Infrastructure as Code
- CI/CD automation
- Kubernetes orchestration
- Cloud platform engineering