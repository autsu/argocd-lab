# ArgoCD支持的Git仓库模式

ArgoCD可以从Git仓库中读取多种类型的Kubernetes配置文件。以下是主要支持的几种模式：

## 1. 原生Kubernetes清单文件

**仓库结构：**

```
kubernetes-manifests/
├── deployment.yaml
├── service.yaml
├── configmap.yaml
└── ...
```

## 2. Helm Chart

**仓库结构：**

```
helm/
└── my-app/
    ├── Chart.yaml
    ├── values.yaml
    ├── templates/
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   └── ...
    └── charts/
```

## 3. Helm Chart仓库引用

无需在Git仓库中存储具体的Helm Chart文件，只需在Application中引用外部Helm仓库。

## 4. Kustomize

**仓库结构：**

```
kustomize/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
└── overlays/
    ├── dev/
    │   └── kustomization.yaml
    └── prod/
        └── kustomization.yaml
```

## 5. App of Apps模式

**仓库结构：**

```
app-of-apps/
├── app1.yaml
├── app2.yaml
└── app3.yaml
```

## 6. Jsonnet

**仓库结构：**

```
jsonnet/
├── main.jsonnet
└── vendor/
    └── jsonnet-libs/
```

每种模式下对应的Application配置样例可参考同目录下的示例文件。
