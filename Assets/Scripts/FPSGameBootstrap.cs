using UnityEngine;

namespace FPS1
{
    public sealed class FPSGameBootstrap : MonoBehaviour
    {
        private void Start()
        {
            CreateEnvironment();
            CreatePlayer();
            CreateHud();
        }

        private static void CreateEnvironment()
        {
            GameObject ground = GameObject.CreatePrimitive(PrimitiveType.Plane);
            ground.name = "Ground";
            ground.transform.localScale = Vector3.one * 20f;

            Material groundMaterial = new Material(Shader.Find("Standard"))
            {
                color = new Color(0.12f, 0.16f, 0.2f)
            };
            ground.GetComponent<Renderer>().sharedMaterial = groundMaterial;

            GameObject lightObject = new GameObject("Directional Light");
            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Directional;
            light.intensity = 1.2f;
            light.color = new Color(1f, 0.93f, 0.8f);
            lightObject.transform.rotation = Quaternion.Euler(50f, -30f, 0f);

            CreateCover(new Vector3(0f, 1f, 7f), new Vector3(3f, 2f, 1f));
            CreateCover(new Vector3(-7f, 1f, 14f), new Vector3(1f, 2f, 4f));
            CreateCover(new Vector3(8f, 1f, 20f), new Vector3(4f, 2f, 1f));
        }

        private static void CreateCover(Vector3 position, Vector3 scale)
        {
            GameObject cover = GameObject.CreatePrimitive(PrimitiveType.Cube);
            cover.name = "Cover";
            cover.transform.position = position;
            cover.transform.localScale = scale;
        }

        private static void CreatePlayer()
        {
            GameObject player = new GameObject("Player");
            player.tag = "Player";
            player.transform.position = new Vector3(0f, 1f, -8f);
            player.AddComponent<CharacterController>();
            player.AddComponent<FPSPlayerController>();

            GameObject cameraObject = new GameObject("Main Camera");
            cameraObject.tag = "MainCamera";
            cameraObject.transform.SetParent(player.transform);
            cameraObject.transform.localPosition = new Vector3(0f, 0.6f, 0f);
            cameraObject.AddComponent<Camera>().fieldOfView = 75f;
            cameraObject.AddComponent<FPSCameraLook>().Initialize(player.transform);
        }

        private static void CreateHud()
        {
            new GameObject("HUD").AddComponent<Crosshair>();
        }
    }
}

