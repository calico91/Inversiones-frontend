import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/client_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/domain/responses/clientes/add_client_response.dart';
import 'package:inversiones/src/domain/responses/clientes/all_clients_response.dart';
import 'package:inversiones/src/domain/responses/clientes/imagenes_cliente_response.dart';
import 'package:inversiones/src/ui/pages/clients/widgets/modal_informacion_cliente.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ClientsController extends GetxController {
  final AppController appController = Get.find<AppController>();

  final TextEditingController name = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController observations = TextEditingController();
  final TextEditingController buscarClienteCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<int> idClient = RxInt(0);
  final Rx<List<Client>> clients = Rx<List<Client>>([]);
  Rx<List<Client>> filtroClientes = Rx<List<Client>>([]);
  final Rx<int> status = Rx<int>(0);

  late Rx<MultiImagePickerController> multiImagePickerController;
  final RxBool estaEditando = false.obs;

  @override
  void onInit() {
    super.onInit();
    multiImagePickerController = Rx(MultiImagePickerController(
        maxImages: 6,
        picker: (bool allowMultiple) async {
          final pickedImages = await pickImages(allowMultiple);
          return pickedImages.map((e) => convertToImageFile(e)).toList();
        }));
  }

  Future<void> allClients() async {
    Get.showOverlay(
        loadingWidget: const CargandoAnimacion(),
        asyncFunction: () async {
          try {
            final AllClientsResponse res =
                await const ClientHttp().allClients();
            clients(res.clients);
            status(res.status);
            filtroClientes(clients.value);

            await const SecureStorageLocal().saveListaClientes(clients.value);
          } on HttpException catch (e) {
            appController.manageError(e.message);
          } catch (e) {
            appController.manageError(e.toString());
          }
        });
  }

  void save() {
    Get.showOverlay(
      loadingWidget: const CargandoAnimacion(),
      asyncFunction: () async {
        final List<Client> listaClienteLocal =
            await const SecureStorageLocal().listaClientes;

        try {
          final AddClientResponse respuestaHTTP = await const ClientHttp()
              .addClient(Client(
                  observaciones: observations.text.trim(),
                  direccion: address.text.trim(),
                  nombres: name.text.trim(),
                  apellidos: lastname.text.trim(),
                  celular: phoneNumber.text.trim(),
                  cedula: document.text.trim(),
                  imagenes: multiImagePickerController.value.images));

          filtroClientes.value.insert(0, respuestaHTTP.client!);

          ///al crearse un cliente se adiciona a la lista local
          listaClienteLocal.insert(0, respuestaHTTP.client!);

          await const SecureStorageLocal().saveListaClientes(listaClienteLocal);

          Get.showSnackbar(const InfoSnackbar('cliente creado correctamente'));
          cleanForm();

          // se realiza validacion para que la lista de clientes se cierre
          //ya que si se crea un cliente no se muestra de inmediato en la lista
          clients([]);
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  void loadClient(String document, bool editar) {
    Get.showOverlay(
      loadingWidget: const CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final AddClientResponse res =
              await const ClientHttp().loadClient(document);

          if (editar) {
            _loadClientForm(res.client!);
            estaEditando(editar);
          } else {
            _mostrarModalInformacionCliente(res.client!);
          }

          idClient(res.client!.id);
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  void updateClient() {
    Get.showOverlay(
      loadingWidget: const CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final AddClientResponse res = await const ClientHttp().updateClient(
            idClient.value,
            Client(
              nombres: name.text,
              apellidos: lastname.text,
              celular: phoneNumber.text.trim(),
              cedula: document.text.trim(),
              direccion: address.text,
              observaciones: observations.text,
            ),
          );
          if (res.status == 200) {
            Get.showSnackbar(
              const InfoSnackbar('cliente actualizado correctamente'),
            );
            cleanForm();
          } else {
            appController.manageError(res.message);
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  Future<void> consultarImagenes(int idCliente) async {
    Get.showOverlay(
        loadingWidget: const CargandoAnimacion(),
        asyncFunction: () async {
          try {
            final ApiResponse<List<ImagenCliente>> respuestaHttp =
                await const ClientHttp().consultarImagenes(idCliente);
          } on HttpException catch (e) {
            appController.manageError(e.message);
          } catch (e) {
            appController.manageError(e.toString());
          }
        });
  }

  void _mostrarModalInformacionCliente(Client data) {
    Get.dialog(
      barrierDismissible: false,
      ModalInformacionCliente(data: data),
    );
  }

  void cleanForm() {
    document.clear();
    lastname.clear();
    name.clear();
    phoneNumber.clear();
    observations.clear();
    address.clear();
    multiImagePickerController.value.clearImages();
    estaEditando(false);
  }

  void _loadClientForm(Client client) {
    document.text = client.cedula;
    lastname.text = client.apellidos;
    name.text = client.nombres;
    address.text = client.direccion;
    observations.text = client.observaciones ?? '';
    phoneNumber.text = client.celular;
  }

  void buscarCliente(String value, bool focus) {
    List<Client> results = [];
    if (value.isEmpty || !focus) {
      results = clients.value;
      buscarClienteCtrl.clear();
    } else {
      results = clients.value
          .where(
            (element) =>
                element.nombres.toLowerCase().contains(value.toLowerCase()) ||
                element.apellidos.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    }
    filtroClientes.value = results;
  }

  void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  Future<List<XFile>> pickImages(bool allowMultiple) async {
    final ImagePicker picker = ImagePicker();
    List<XFile>? pickedFiles;
    if (allowMultiple) {
      pickedFiles = await picker.pickMultiImage();
    } else {
      final XFile? singleFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (singleFile != null) {
        pickedFiles = [singleFile];
      }
    }
    return pickedFiles ?? [];
  }

  ImageFile convertToImageFile(XFile file) {
    return ImageFile(
      file.path, // Argumento posicional requerido
      path: file.path,
      name: file.name,
      extension: file.path.split('.').last, // Extrae la extensión del archivo
    );
  }
}
