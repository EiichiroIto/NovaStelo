class SDiffuser {
 public:
  void nsum4(const float *src, float *dst, int cols, int rows);
  void nsum8(const float *src, float *dst, int cols, int rows);
  void diffuse4(float *buf, int cols, int rows, float percent);
  void diffuse8(float *buf, int cols, int rows, float percent);

  void rolledUp(const float *src, float *dst, int cols, int count);
  void rolledDown(const float *src, float *dst, int cols, int count);
  void rolledLeft(const float *src, float *dst, int cols, int count);
  void rolledRight(const float *src, float *dst, int cols, int count);
  void addTo(const float *src, float *dst, int count);
  void copyFloatArray(const float *src, float *dst, int count);
  void mulScalar(float *dst, float scalar, int count);
};
