```mermaid
graph TD
    subgraph "BrowserController.onLoadStop"
        A[ページ読み込み完了 onLoadStop] --> B{loadedUrlがnullか？};
        B -- Yes --> C[処理終了];
        B -- No --> D[URL文字列取得];
        D --> E[ページタイトル取得];
        E --> F[urlTitlesマップにタイトルを保存];
        F --> G{canAddChildNodeがtrueか？};
        G -- Yes --> H[新ノードを現在ノードの子として追加];
        H --> I[現在ノードを新ノードに更新];
        G -- No --> J[履歴ツリーに追加しない];
        I --> K{Google以外のURLか？};
        J --> K;
        K -- Yes --> L[下部ボタンリストに新ノードを追加];
        K -- No --> M[下部ボタンリストに追加しない];
        L --> C;
        M --> C;
    end

    subgraph "BrowserController.shouldOverrideUrlLoading(一般的なリンククリック)"
        N[リンククリックshouldOverrideUrlLoading] --> O[URL文字列取得];
        O --> P[デバッグログ出力];
        P --> Q[新ノード生成 currentNodeの子];
        Q --> R{canAddChildNodeがtrueか？};
        R -- Yes --> S[新ノードを履歴ツリーに追加];
        S --> T[現在ノードを新ノードに更新];
        R -- No --> U[履歴ツリーに追加しない];
        T --> V{Google以外のURLか？};
        U --> V;
        V -- Yes --> W[下部ボタンリストに新ノードを追加];
        V -- No --> X[下部ボタンリストに追加しない];
        W --> Y[ページ遷移を許可 ALLOW];
        X --> Y;
        Y --> Z[処理終了];
    end

    subgraph "BrowserController.shouldOverrideUrlLoadingRoot (特定のリンククリック)"
        AA[リンククリック shouldOverrideUrlLoadingRoot] --> BB[URL文字列取得];
        BB --> CC[ページタイトル取得];
        CC --> DD[ノード名決定 タイトルまたはURL、10文字制限];
        DD --> EE[NodeWithURLで子ノード生成 rootNodeの子];
        EE --> FF[rootNodeに子ノードを追加];
        FF --> GG[下部ボタンに追加];
        GG --> HH[ページ遷移をキャンセル CANCEL];
        HH --> II[処理終了];
    end

    subgraph BrowserController.buildFloatingButtons
        J1[buildFloatingButtons] --> J2[Column Widget];
        J2 --> J3[戻るボタン FloatingActionButton];
        J3 --> J4{WebViewに戻れる履歴があるか？};
        J4 -- Yes --> J5[WebViewを1つ戻る];
        J4 -- No --> J6[何もしない];
        J5 --> J7[SizedBox];
        J6 --> J7;
        J7 --> J8[Row Widget];
        J8 --> J9[ノード追加切替ボタン FloatingActionButton];
        J9 --> J10[canAddChildNodeを切り替える setState];
        J8 --> J11[SizedBox];
        J11 --> J12[ノード追加切替スイッチ Switch];
        J12 --> J13[canAddChildNodeを切り替える setState];
        J10 --> J14[処理終了];
        J13 --> J14;
    end
