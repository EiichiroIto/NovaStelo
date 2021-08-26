class SDiffuser {
 private:
  float *_extended;
  float *_normal;
  int _size;
  int _cols;
  int _rows;
  int _neighborSize;
  int neighbor[8];

  void free();
  void allocate(int size);
  void setupNsum(const float *extended, float *normal, int cols, int rows, int neighborSize);
  void setupDiffuse(float *buf, int cols, int rows, int neighborSize);
  void setupExtended(const float *extended);
  void clearExtended();
  int indexOfExtended(int x, int y) const;
  int indexOfNormal(int x, int y) const;
  void setupNeighbor();
  void setupBorder();
  void nsum();
  void diffuse(float percent);
  void restoreExtended(float *buf);

 public:
  SDiffuser();
  ~SDiffuser();

  void nsum4(const float *src, float *dst, int cols, int rows);
  void nsum8(const float *src, float *dst, int cols, int rows);
  void diffuse4(float *buf, int cols, int rows, float percent);
  void diffuse8(float *buf, int cols, int rows, float percent);
  void printExtended() const;
  void printNeighbor() const;
};
