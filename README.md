# Flutter Module Architecture

Arquitetura para criar módulos Flutter isolados, reutilizáveis em qualquer app, independente do sistema de rotas.

---

## Demo

<!-- Insira aqui o vídeo demonstrando o fluxo completo -->

[https://github.com/user-attachments/assets/VIDEO_ID](https://github.com/user-attachments/assets/0bbecd91-a5aa-45d2-b8b1-d8551ebff9fc)

---

## Conceito

Cada módulo é uma caixa-preta. O app host só conhece duas coisas:

```dart
// Entry point (widget)
PaymentEntryPoint(
  initialRoute: PaymentHome(),
  onFlowFinished: () => /* host decide */,
)

// Rotas (sealed class)
PaymentHome()
PaymentDetail('123')
PaymentSuccess('txn-abc')
```

Entrou no módulo → DI inicializada automaticamente.
Saiu do módulo → DI limpa automaticamente.
Zero acoplamento com GoRouter, Modular, Navigator ou qualquer outro.

---

## Arquitetura


```
┌─────────────────────────────────────────────────┐
│                   APP HOST                       │
│          (qualquer sistema de rotas)             │
│                                                  │
│   PaymentEntryPoint(                             │
│     initialRoute: PaymentHome(),                 │
│     onFlowFinished: () => router.go('/home'),    │
│   )                                              │
│                                                  │
│   ┌──────────────────────────────────────────┐   │
│   │           MÓDULO (caixa-preta)            │   │
│   │                                          │   │
│   │  initState() → setup DI (GetIt scope)    │   │
│   │  dispose()   → limpa DI (drop scope)     │   │
│   │                                          │   │
│   │  Navigator aninhado (isolado)            │   │
│   │  ┌────────┐  ┌────────┐  ┌───────────┐  │   │
│   │  │  Home  │→ │ Detail │→ │  Success  │  │   │
│   │  └────────┘  └────────┘  └─────┬─────┘  │   │
│   │                                │        │   │
│   │                 onFlowFinished()│        │   │
│   └────────────────────────────────┼────────┘   │
│                                    ↓             │
│              host decide o que fazer             │
└─────────────────────────────────────────────────┘
```
