typedef struct {
  int kind;
  int xdata;
  const void *data[3];
} CXCursor;

enum CXChildVisitResult {
  CXChildVisit_Break,
  CXChildVisit_Continue,
  CXChildVisit_Recurse
};

typedef enum CXChildVisitResult (*callback)(CXCursor* cursor, CXCursor* parent);

typedef enum CXChildVisitResult (*CXCursorVisitor)(CXCursor cursor,
                                                   CXCursor parent,
                                                   void* client_data);

enum CXChildVisitResult ljclang_tree_visitor(CXCursor cursor, CXCursor parent,
    void* data) { return ((callback)data)(&cursor, &parent); }
