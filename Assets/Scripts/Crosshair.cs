using UnityEngine;

namespace FPS1
{
    public sealed class Crosshair : MonoBehaviour
    {
        [SerializeField] private float size = 8f;
        [SerializeField] private float thickness = 2f;
        [SerializeField] private Color color = Color.white;

        private void OnGUI()
        {
            float centerX = (Screen.width - size) * 0.5f;
            float centerY = (Screen.height - size) * 0.5f;
            GUI.color = color;
            GUI.DrawTexture(new Rect(centerX, centerY, size, thickness), Texture2D.whiteTexture);
            GUI.DrawTexture(new Rect(centerX, centerY, thickness, size), Texture2D.whiteTexture);
        }
    }
}

