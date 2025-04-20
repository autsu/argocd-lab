# ArgoCD实践指南

本仓库包含了ArgoCD的各种应用部署模式示例，可用于学习和实践ArgoCD的GitOps工作流。

## 目录结构

```
/
├── application.yaml       # 基本的Application示例
├── dev/                   # 原生Kubernetes清单示例
│   ├── deployment.yaml
│   └── service.yaml
├── helm/                  # Helm Chart示例
│   └── nginx/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
├── kustomize/             # Kustomize示例
│   ├── base/
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── prod/
│           ├── kustomization.yaml
│           └── service-patch.yaml
├── app-of-apps/           # App of Apps模式示例
│   ├── nginx-app.yaml
│   └── kustomize-app.yaml
├── jsonnet/               # Jsonnet模式示例
│   ├── main.jsonnet
│   └── vendor/
│       └── jsonnet-libs/
└── examples/              # 各种Application定义示例
    ├── kubernetes-manifests-application.yaml
    ├── helm-chart-application.yaml
    ├── helm-repo-application.yaml
    ├── kustomize-application.yaml
    ├── app-of-apps.yaml
    ├── jsonnet-application.yaml
    └── README.md
```

## ArgoCD支持的配置模式

ArgoCD支持从Git仓库中读取多种类型的Kubernetes配置文件：

1. **原生Kubernetes清单文件**: YAML格式的Deployment、Service等资源定义
2. **Helm Chart**: 完整的Helm应用包，包含Chart.yaml、values.yaml和templates
3. **Helm仓库引用**: 直接引用外部Helm仓库中的Chart，无需在Git中存储
4. **Kustomize**: 使用Kubernetes原生的Kustomize工具进行资源定义和环境管理
5. **App of Apps**: 通过一个主Application管理多个子Application
6. **Jsonnet**: 使用Jsonnet语言进行更灵活的资源定义

## 实践步骤

1. 克隆本仓库到您的GitHub账号

   ```bash
   git clone https://github.com/autsu/argocd-lab.git
   cd argocd-lab
   git remote set-url origin https://github.com/YOUR_USERNAME/argocd-lab.git
   git push -u origin main
   ```

2. 在K8s集群中部署ArgoCD

   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

3. 安装ArgoCD CLI并访问UI

   ```bash
   # 端口转发
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   
   # 获取初始密码
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   ```

4. 部署示例应用

   ```bash
   # 部署基本Kubernetes清单应用
   kubectl apply -f examples/kubernetes-manifests-application.yaml
   
   # 部署Helm Chart应用
   kubectl apply -f examples/helm-chart-application.yaml
   
   # 部署外部Helm仓库应用
   kubectl apply -f examples/helm-repo-application.yaml
   
   # 部署Kustomize应用
   kubectl apply -f examples/kustomize-application.yaml
   
   # 部署App of Apps
   kubectl apply -f examples/app-of-apps.yaml
   
   # 部署Jsonnet应用
   kubectl apply -f examples/jsonnet-application.yaml
   ```

5. 观察同步结果
   - 通过ArgoCD UI查看应用同步状态
   - 修改Git仓库中的配置，观察自动同步行为

## 学习资源

- [ArgoCD官方文档](https://argo-cd.readthedocs.io/)
- [Helm官方文档](https://helm.sh/docs/)
- [Kustomize官方文档](https://kustomize.io/)
- [Jsonnet官方文档](https://jsonnet.org/learning/tutorial.html)
