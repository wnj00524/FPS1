using UnityEngine;

namespace FPS1
{
    public sealed class FPSCameraLook : MonoBehaviour
    {
        [SerializeField] private Transform playerBody;
        [SerializeField] private float sensitivity = 2.2f;
        [SerializeField] private float maxLookAngle = 85f;

        private float pitch;

        public void Initialize(Transform body)
        {
            playerBody = body;
        }

        private void Start()
        {
            Cursor.lockState = CursorLockMode.Locked;
            Cursor.visible = false;
        }

        private void Update()
        {
            if (Cursor.lockState != CursorLockMode.Locked && Input.GetMouseButtonDown(0))
            {
                Cursor.lockState = CursorLockMode.Locked;
                Cursor.visible = false;
            }

            if (Cursor.lockState != CursorLockMode.Locked)
            {
                return;
            }

            float yaw = Input.GetAxis("Mouse X") * sensitivity;
            float look = Input.GetAxis("Mouse Y") * sensitivity;
            pitch = Mathf.Clamp(pitch - look, -maxLookAngle, maxLookAngle);

            transform.localRotation = Quaternion.Euler(pitch, 0f, 0f);
            playerBody.Rotate(Vector3.up * yaw);
        }
    }
}
